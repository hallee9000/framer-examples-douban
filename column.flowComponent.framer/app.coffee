# 1、创建流组件，搭建基本框架
flow = new FlowComponent
	backgroundColor: "#FFF"
# 将顶栏和低栏加入页面流，这样它们就会固定在顶部和底部了
flow.header = statusBar
flow.footer = footer

# 2、一些底部菜单状态处理的初始化工作
# 将底部按钮存在一个数组中，方便后续使用
footerBtns = [todayIcon,gamesIcon,appsIcon,updatesIcon,searchIcon]
# 点击按底栏的钮时改变按钮颜色的函数
# 点击时将所有按钮变成灰色，只将当前点击的按钮变成蓝色
changePage = (index) ->
	for btn in footerBtns
		btn.grayscale = 100
	footerBtns[index].grayscale = 0
# 将首页 today 加入页面流
flow.showNext(today)
# 高亮 today 菜单
changePage(0)

# 3、自定义 today 和 games 页面切换的效果
# 自定义过渡函数
gamesTransition = (nav, layerA, layerB, overlay) ->
	transition =
		layerA:
			show:
				x: 0
				y: 0
			hide:
				x: -Screen.width
				y: 0
		layerB:
			show:
				x: 0
				y: 0
			hide:
				x: Screen.width
				y: 0
# 点击游戏图标进入 games 页面
# 使用刚才自定义的过渡函数
gamesIcon.onClick ->
	changePage(1)
	flow.transition(games, gamesTransition)
# 点击今日图标进入 today
todayIcon.onClick ->
	changePage(0)
	flow.showPrevious()

# 4、点击首页纪念碑谷卡片，展开卡片出现详细介绍
# 创建详情页的滚动容器
todayScroller = new ScrollComponent
	width: 328
	height: 393
	parent: monument
	scrollHorizontal: false
	scrollVertical: false
# 将详情加入滚动组件
today_detail.parent = todayScroller.content
today_detail.x = 0
today_detail.y = 0
# 因为 today_detail 画板自带坐标值，会把滚动组件撑大，所以需要重新计算一下
todayScroller.updateContent()
# 将海报拉长盖满卡片
poster.height = 393
# 卡片展开的状态
monument.states.expanding =
	x: 0
	y: 0
	width : Screen.width
	height : Screen.height
	borderRadius : 0
# 滚动组件在卡片展开时的状态
todayScroller.states.expanding =
	width : Screen.width
	height : Screen.height
	scrollVertical : true
# 点击纪念碑谷卡片
monument.onClick ->
	if !flow.scroll.isMoving
		# 移到 flow 下才不会被顶栏和底栏挡住
		this.parent = flow
		this.animate('expanding')
		# 滚动组件变为展开状态
		todayScroller.animate('expanding')
		# 图片高度变低
		poster.animate
			height: 280
		# 显示关闭按钮
		monumentClose.animate
			opacity : 1
		# 将关闭按钮放置最前
		monumentClose.bringToFront()

# 点击关闭按钮，卡片复位
monumentClose.onClick ->
	monument.animate('default')
	Utils.delay 0.1,->
		# 延迟 0.1 秒后卡片回到首页中
		monument.parent = today
		# 延迟 0.1 秒后内容回到顶部，滚动组件回到初始状态，禁止纵向滚动
		todayScroller.scrollToLayer(today_detail)
		todayScroller.animate('default')
	# 图片变高，撑满整个卡片
	poster.animate
		height: 393
	# 关闭按钮消失
	monumentClose.animate
		opacity : 0

# 5、点击第二张卡片，进入 app 详情页
# 进入详情页之后，底栏向下滑动隐去
footer.states.disappear =
	y: Screen.height
# 点击卡片隐藏底栏，流到详情页
geometrics.onClick ->
	if !flow.scroll.isMoving
		flow.showNext(app_detail)
		footer.animate('disappear')

# 创建详情页的滚动容器
detailScroller = new ScrollComponent
	width: Screen.width
	height: Screen.height
	parent: app_detail
	scrollHorizontal: false
# 将滚动组件移动到后面以免其遮挡导航条
detailScroller.sendToBack()
# 将详情长图设为滚动组件内容的子图层
detailContent.parent = detailScroller.content
detailContent.x = 0
detailContent.y = 0
# 导航条内快捷下载按钮随着滚动内容进行动画
shortcutGroup.states.visible =
	y: 3
	opacity: 1
shortcutGroup.animationOptions =
	time: 0.2
# 检测滚动的位置，当远离顶部时在顶栏显示快捷下载按钮和 app 图标
# 当靠近顶部时，隐藏它们
detailScroller.content.on "change:y", ->
	if detailScroller.scrollY>44
		shortcutGroup.animate('visible')
	else
		shortcutGroup.animate('default')
# 点击返回按钮从详情回到主页
backToApps.onClick ->
	footer.animate('default')
	flow.showPrevious()
