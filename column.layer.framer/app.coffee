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
