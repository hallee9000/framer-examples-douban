# 新建一个按钮图层
button = new Layer
	x: 204
	y: 382
	width: 160
	height: 40
	backgroundColor: "#33CC00"
# 新建一个文字图层的容器
textContainer = new Layer
	parent: button
	width: 160
	height: 80
	backgroundColor: 'transparent'
# 新建文字图层 play
play = new TextLayer
	text: '播放'
	parent: textContainer
	width: 160
	textAlign: 'center'
	fontSize: 16
	lineHeight: 2.5
	color: 'white'
# 新建文字图层 pause
pause = new TextLayer
	y: 40
	text: '暂停'
	parent: textContainer
	width: 160
	textAlign: 'center'
	fontSize: 16
	lineHeight: 2.5
	color: 'white'
# 给button图层添加新状态
button.states.pause =
	backgroundColor: "#FF3300"
# 给文本容器图层添加新状态
textContainer.states.pause =
	y: -40
# 给button图层添加点击事件，触发过渡动画
button.onClick (event, layer) ->
	button.stateCycle()
	textContainer.stateCycle()
	
	
