# 绘制图层
light = []

for i in [0..7]
	light[i] = new Layer
		parent: sun
		x: 90
		y: -70
		width: 20
		height: 50
		backgroundColor: '#FCD738'
		borderRadius: 10
		originY: 3.4
		rotation: 45*i
	light[i].states.night =
		opacity: 0
		animationOptions:
			time: 4
	light[i].animate("night")


sun.blur = 2

# 给图层添加状态
sun.states.night =
	x: 90
	backgroundColor: "#EEE"
	animationOptions:
		time: 4
sky.states.night =
	backgroundColor: "#040C0F"
	animationOptions:
		time: 4
cloud.states.night =
	x: 260
	y: 330
	brightness: 10
	animationOptions:
		time: 4

# 让图层以动画的形式在状态之间转换
sun.animate("night")
sky.animate("night")
cloud.animate("night")
