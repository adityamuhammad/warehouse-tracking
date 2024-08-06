package handlers

import (
	"net/http"
	"warehouse-tracking/config"
	"warehouse-tracking/models"

	"github.com/gin-gonic/gin"
)

func CreateItem(c *gin.Context) {
	var createItemRequest models.CreateItemRequest
	if err := c.ShouldBindJSON(&createItemRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	var item models.Item
	item.Name = createItemRequest.Name
	item.CurrentStock = 0

	config.DB.Create(&item)
	c.JSON(http.StatusOK, gin.H{"data": item})
}

func UpdateStockItem(c *gin.Context) {
	var updateStockItemRequest models.UpdateStockItemRequest
	if err := c.ShouldBindJSON(&updateStockItemRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	var item models.Item
	if err := config.DB.First(&item, updateStockItemRequest.ItemId).Error; err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Item not found"})
		return
	}

	var stockBefore = item.CurrentStock
	var stockAfter = stockBefore + updateStockItemRequest.Stock

	item.CurrentStock = stockAfter
	config.DB.Save(&item)

	var itemTracking models.ItemTracking
	itemTracking.ItemId = item.ID
	itemTracking.Stock = updateStockItemRequest.Stock
	itemTracking.StockBefore = stockBefore
	itemTracking.StockAfter = stockAfter
	itemTracking.Remark = updateStockItemRequest.Remark
	itemTracking.UpdatedById = updateStockItemRequest.UpdatedById
	itemTracking.UpdatedByRole = updateStockItemRequest.UpdatedByRole

	config.DB.Create(&itemTracking)

	c.JSON(http.StatusOK, gin.H{"data": item})
}

func GetSummaryStockItem(c *gin.Context) {
	var itemInResponse []models.ItemInResponse
	var itemOutResponse []models.ItemOutResponse
	var itemRemainingResponse []models.ItemRemainingResponse

	queryItemIn := `
		select i.id item_id, i.name item_name , sum(it.stock) total_in, concat(year(it.created_at), '-', month(it.created_at)) period
		from item_trackings it
		join items i on it.item_id = i.id
		where it.stock > 0
		group by i.id, period
	`

	if err := config.DB.Raw(queryItemIn).Scan(&itemInResponse).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch item in"})
		return
	}

	queryItemOut := `
		select i.id item_id, i.name item_name, sum(it.stock) total_out, concat(year(it.created_at), '-', month(it.created_at)) period
		from item_trackings it
		join items i on it.item_id = i.id
		where it.stock < 0
		group by i.id, period

	`

	if err := config.DB.Raw(queryItemOut).Scan(&itemOutResponse).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch item out"})
		return
	}

	queryItemRemaining := `
		select i.id item_id, i.name item_name, it.stock_after total_remaining, sub_it.period
		from item_trackings it
		join items i on it.item_id = i.id
		join (
			select max(_it.id) id, concat(year(_it.created_at), '-', month(_it.created_at)) period 
			from item_trackings _it
			group by _it.item_id, period
		) sub_it on it.id = sub_it.id
	`

	if err := config.DB.Raw(queryItemRemaining).Scan(&itemRemainingResponse).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch item remaining"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"item_in":        itemInResponse,
		"item_out":       itemOutResponse,
		"item_remaining": itemRemainingResponse,
	})

}
func GetAverageItemInPerSupplier(c *gin.Context) {
	var response []models.ItemInAverageResponse

	query := `
		select i.id item_id, i.name item_name , avg(it.stock) total_in_average, s.name supplier_name
		from item_trackings it
		join items i on it.item_id = i.id
		join suppliers s on it.updated_by_id = s.id
		where it.stock > 0 and it.updated_by_role = 'Supplier'
		group by i.id, it.updated_by_id

	`

	if err := config.DB.Raw(query).Scan(&response).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to fetch item in"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"data": response,
	})

}
