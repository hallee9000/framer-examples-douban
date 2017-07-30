Screen.backgroundColor = "black"

# 创建滑块组件及自定义样式
slider = new SliderComponent
	point: Align.center
	knobSize: 16
	x: 35
	y: 590
	height: 2
	width: 300
	backgroundColor: "#333"

slider.knob.backgroundColor = "#666"
slider.fill.backgroundColor = "#AAA"

# 创建需要被调整的图片图层
picture = new Layer
	width: 300
	height: 300
	image: "images/picture.jpg"
	x: 35
	y: 107

# 定义一些变量
buttons = [ brightness, saturate, invert, grayscale, contrast ]
ranges = [[0,200],[0,200],[0,100],[0,100],[0,200]]

currentTuning = 'brightness'
currentIndex = 0

# 绑定按钮点击事件
for i in [0...buttons.length]
	buttons[i].onClick ->
		for button in buttons
			button.opacity = 1
		this.opacity = 0.5
		currentTuning = this.name
		currentIndex = buttons.indexOf(this)
		slideValue = Utils.modulate(picture[currentTuning], ranges[currentIndex] , [0, 1])
		slider.animateToValue(slideValue)

# 监听是否在滑动滑块
slider.onValueChange ->
	picture[currentTuning] = Utils.modulate(slider.value, [0, 1], ranges[currentIndex] )

# 设置初始值
slider.value = Utils.modulate(picture.brightness, [0, 200], [0,1] )
buttons[0].opacity = 0.5

