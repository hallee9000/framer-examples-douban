# 创建显示价格范围的文字图层
rangeText = new TextLayer
	x: Align.center
	y: 150
	width: Screen.width
	text: "{minPrice}-{maxPrice} 元"
	textAlign: "center"
	fontSize: 30
	color: "#FFF"
# 设置其初始显示的范围
rangeText.template =
	minPrice: 0
	maxPrice: 1000

# 创建显示结果的文字图层
resultButton = new TextLayer
	x: Align.center
	y: 640
	width: Screen.width/2
	height: 40
	text: "共有{amount}个房源"
	textAlign: "center"
	fontSize: 14
	color: "#FFF"
	backgroundColor: "rgba(2,103,225,1)"
	borderRadius: 20
	lineHeight: 2.7
# 设置其初始值
resultButton.template = 1270
# 格式化显示的值，不保留小数
resultButton.templateFormatter = (value) ->
    Utils.round(value, 0)

# 创建一个范围组件
range = new RangeSliderComponent
	x: Align.center
	y: Align.center(16)
	height: 5
	knobSize: 20
	min: 0
	max: 1000
	minValue: 0
	maxValue: 1000
# 创建一个浅蓝色到深蓝色的渐变
blueGradient = new Gradient
	start: "#0DF"
	end: "#05F"
	angle: 90
# 定制范围组建的外观
range.fill.backgroundColor = 'transparent'
range.gradient = blueGradient
range.maxKnob.backgroundColor = "#05F"
range.minKnob.backgroundColor = "#0DF"

# 监听范围组件的值变化，同时改变价格区间显示的值和结果按钮显示的值
range.onValueChange ->
	rangeText.template =
		minPrice: Utils.round(range.minValue, 0)
		maxPrice: Utils.round(range.maxValue, 0)
	resultButton.template = Utils.randomNumber(0,range.maxValue-range.minValue)


