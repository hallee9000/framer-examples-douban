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

sun.blur = 2

# 给云朵添加事件
cloud.states.float =
	x: 260

cloud.onClick (event, layer) ->
	if cloud.states.current.name=='float'
		cloud.animate('default')
	else
		cloud.animate('float')

# 避让效果
weather.center()

canvasWidth = Canvas.width
canvasHeight = Canvas.height

sky.onMouseMove (event, layer) ->
	weather.midX = Utils.modulate(event.point.x, [0, canvasWidth], [canvasWidth/2+40,canvasWidth/2-40])
	weather.midY = Utils.modulate(event.point.y, [0, canvasHeight], [canvasHeight/2+40, canvasHeight/2-40])
