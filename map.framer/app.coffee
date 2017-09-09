# 创建页面流组件，初始化工作
flow = new FlowComponent
flow.header = search
flow.showNext(map)

# 让地图可以被拖动，双指缩放
flow.scroll.content.y = 0
flow.scroll.content.draggable.constraints =
	x: -911
	y: -15
	width: 2233
	height: 760
map.pinchable.enabled = true
map.pinchable.rotate = false

# 给详情页添加两个状态，同时让详情页内容可被拖动
detail.clip = false
detail.states.appearing =
	x: 0
	y: 490
	animationOptions:
		time: 0.8
detail.states.covering =
	x: 0
	y: 14
	animationOptions:
		time: 0.8
detailContent.draggable.enabled = true
detailContent.draggable.horizontal = false
detailContent.draggable.constraints =
	height: 717

# 地图上标记一闪一闪的效果
pointBlink = new Animation point,
	scale: 2
	opacity: 0
	options:
		looping: true
pointBlink.start()

# 给搜索框添加隐藏的状态
search.states.hidden =
	y: -50

# 将浮层底色改成透明的
flow.overlay.backgroundColor = 'transparent'

# 点击标记，从底部弹出浮层
point.onClick ->
	flow.showOverlayBottom(detail)

# 处理详情页的拖动，让它在覆盖屏幕、露出一半和浮层关闭的状态之间切换
detailContent.on Events.DragEnd, (offset, layer) ->
	scrollY = detailContent.draggable.offset.y
	direction = detailContent.draggable.direction
	# 向下滑动时
	if scrollY > 50 and direction is 'down'
		search.animate('default')
		# 当前处于完全覆盖状态时
		if detail.states.current.name is 'covering'
			detail.animate('appearing')
		# 当前处于刚刚露出一部分状态时
		else
			flow.showPrevious()
	# 向上滑动时
	if scrollY < -50 and direction is 'up'
		detail.animate('covering')
		search.animate('hidden')
