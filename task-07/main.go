package main

import (
	"strconv"
	"syscall/js"
)

var Count = 0

func Increment(this js.Value, i []js.Value) interface{} {
	value2 := strconv.Itoa(1)

	int2, _ := strconv.Atoi(value2)

	js.Global().Set("output", js.ValueOf(Count+int2))
	Count = Count + int2
	println(Count)
	document := js.Global().Get("document")
	document.Call("getElementById", "int").Set("innerHTML", Count)

	return Count
}

func Decrement(this js.Value, i []js.Value) interface{} {
	value2 := strconv.Itoa(1)

	int2, _ := strconv.Atoi(value2)

	js.Global().Set("output", js.ValueOf(Count-int2))
	Count = Count - int2
	println(Count)
	document := js.Global().Get("document")

	document.Call("getElementById", "int").Set("innerHTML", Count)

	return Count
}

func Reset(this js.Value, i []js.Value) interface{} {
	js.Global().Set("output", js.ValueOf(0))
	println("initialized bob")

	document := js.Global().Get("document")
	Count = 0
	document.Call("getElementById", "int").Set("innerHTML", Count)

	return Count
}

func registerCallBack() {
	js.Global().Get("document").Set("Increment", js.FuncOf(Increment))
	js.Global().Get("document").Set("Decrement", js.FuncOf(Decrement))
	js.Global().Get("document").Set("Reset", js.FuncOf(Reset))

}

func main() {

	js.Global().Set("output", js.ValueOf(Count))

	c := make(chan struct{}, 0)
	println("initialized bob")
	registerCallBack()
	<-c
}
