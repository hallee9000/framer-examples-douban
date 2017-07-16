scroll = new ScrollComponent
	size: Screen.size
	scrollHorizontal: false
	backgroundColor: '#EEE'

# 创建一些图层
poster = new Layer
	parent: scroll.content
	width: 320
	height: 200
	image: "images/poster.jpg"

navTail = new Layer
	parent: scroll.content
	width: 320
	height: 100
	y: 250
	backgroundColor: '#5247C3'

rateList = new Layer
	parent: scroll.content
	x: 23
	y: 250
	width: 274
	height: 602
	image: "images/rate.png"
	shadowBlur: 35
	shadowColor: "rgba(0,0,0,0.15)"

nav = new Layer
	parent: scroll.content
	width: 320
	height: 50
	y: 200
	backgroundColor: '#5247C3'

navInner = new Layer
	parent: nav
	width: 274
	x: 23
	backgroundColor: 'transparent'

rateText = new TextLayer
	parent: navInner
	text: "评分"
	fontSize: 14
	color: 'white'
	y: 10
	height: 22
	style :
		"border-bottom": "2px solid #FFF"

pictureText = new TextLayer
	parent: navInner
	text: "图片"
	fontSize: 14
	color: 'white'
	x: 66
	y: 10

commentText = new TextLayer
	parent: navInner
	text: "影评"
	fontSize: 14
	color: 'white'
	x: 137
	y: 10

left.bringToFront()

# 监听滚动事件
# scroll.onScroll ->
scroll.content.on "change:y", ->
	navTail.height = Utils.modulate(scroll.scrollY,[0,200],[100,0])
	navInner.x = Utils.modulate(scroll.scrollY,[0,200],[23,40],true)
	if scroll.scrollY>200
		nav.y = scroll.scrollY
	else
		nav.y = 200