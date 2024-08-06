package main

import (
	"log"
	"warehouse-tracking/config"
	"warehouse-tracking/handlers"
	"warehouse-tracking/models"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func init() {
	// Load environment variables from .env file
	if err := godotenv.Load(); err != nil {
		log.Printf("No .env file found")
	}
}

func main() {
	r := gin.Default()

	config.ConnectDatabase()

	config.DB.AutoMigrate(&models.Distributor{}, &models.Supplier{}, &models.Item{}, &models.ItemTracking{})

	r.POST("/create-item", handlers.CreateItem)
	r.POST("/update-stock-item", handlers.UpdateStockItem)
	r.GET("/summary-stock-item", handlers.GetSummaryStockItem)
	r.GET("/average-item-in-per-supplier", handlers.GetAverageItemInPerSupplier)

	r.Run(":8080")
}
