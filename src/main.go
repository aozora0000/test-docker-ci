package main

import (
	"github.com/labstack/echo"
	"github.com/labstack/echo/middleware"
)

type ResponseJson struct {
	context string `json:"context"`
}

// start web-app server after middleware setting
func main() {
	e := echo.New()
	e.Use(middleware.Recover())
	e.Use(middleware.Logger())
	e.Use(middleware.Gzip())
	e.GET("/*", func(c echo.Context) error {
		return c.JSON(200 , ResponseJson{"OK"})
	})
	e.Logger.Fatal(e.Start(":8080"))
}
