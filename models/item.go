package models

import "time"

type Item struct {
	ID           uint      `gorm:"primaryKey"`
	Name         string    `json:"name"`
	CurrentStock int       `json:"current_stock"`
	CreatedAt    time.Time `json:"created_at"`
	UpdatedAt    time.Time `json:"updated_at"`
}

type CreateItemRequest struct {
	Name string `json:"name"`
}
