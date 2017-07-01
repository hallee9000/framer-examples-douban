# 绘制图层
light = []
animationLight = []

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
	animationLight[i] = new Animation light[i],
		opacity: 1
		options:
			time: 2

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

# 给图层添加动画
animationCloud = new Animation cloud,
	x: 220
	brightness: 100
	options:
		time: 2

animationSun = new Animation sun,
	rotation: 240
	x: 162
	backgroundColor: "#FCB62C"
	options:
		time: 2
 
animationSky = new Animation sky,
	backgroundColor: "#29BBFF"
	options:
		time: 2

Utils.delay 4, ->
	animationCloud.start()
	animationSun.start()
	animationSky.start()
	for i in [0..7]
		animationLight[i].start()
