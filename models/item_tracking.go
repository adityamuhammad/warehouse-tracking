package models

import "time"

type ItemTracking struct {
	ID            uint      `gorm:"primaryKey"`
	ItemId        uint      `json:"item_id"`
	Stock         int       `json:"stock"`
	StockBefore   int       `json:"stock_before"`
	StockAfter    int       `json:"stock_after"`
	UpdatedById   uint      `json:"updated_by_id"`
	UpdatedByRole string    `json:"updated_by_role"`
	Remark        string    `json:"remark"`
	CreatedAt     time.Time `json:"created_at"`
	UpdatedAt     time.Time `json:"updated_at"`
}

type UpdateStockItemRequest struct {
	ItemId        uint   `json:"item_id"`
	Stock         int    `json:"stock"`
	UpdatedById   uint   `json:"updated_by_id"`
	UpdatedByRole string `json:"updated_by_role"`
	Remark        string `json:"remark"`
}

type ItemInResponse struct {
	ItemId   uint   `json:"item_id"`
	ItemName string `json:"item_name"`
	TotalIn  int    `json:"total_in"`
	Period   string `json:"period"`
}

type ItemOutResponse struct {
	ItemId   uint   `json:"item_id"`
	ItemName string `json:"item_name"`
	TotalOut int    `json:"total_out"`
	Period   string `json:"period"`
}

type ItemRemainingResponse struct {
	ItemId         uint   `json:"item_id"`
	ItemName       string `json:"item_name"`
	TotalRemaining int    `json:"total_remaining"`
	Period         string `json:"period"`
}

type ItemInAverageResponse struct {
	ItemId         uint    `json:"item_id"`
	ItemName       string  `json:"item_name"`
	TotalInAverage float32 `json:"total_in_average"`
	SupplierName   string  `json:"supplier_name"`
}
