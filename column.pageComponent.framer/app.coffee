# Import file "player"
playerSketch = Framer.Importer.load("imported/player@2x", scale: 1)

# 创建页面组件
covers = new PageComponent
	x: Align.center
	y: 123
	width: 366
	height: 366
	scrollVertical: false
	clip: false

# 给页面组件添加页面
covers.addPage(playerSketch.wutiaoren)
covers.addPage(playerSketch.dashayu)
covers.addPage(playerSketch.xietianxiao)

# 添加歌曲信息
songs = new PageComponent
	x: Align.center
	y: 500
	width: Screen.width
	height: 50
	scrollHorizontal: false

songsInformation = [
	{
		name: "广东姑娘"
		band: "五条人"
	},{
		name: "心要野"
		band: "后海大鲨鱼"
	},{
		name: "把黑夜染黑"
		band: "谢天笑"
	}
]

song = []
band = []
songPages = []

for i in [0..2]
	songPages[i] = new Layer
		parent: songs.content
		x: Align.center
		y: songs.height * i
		height: 50
		backgroundColor: 'transparent'
	song[i] = new TextLayer
		parent: songPages[i]
		text: songsInformation[i].name
		color: '#333'
		fontSize: 20
		x: Align.center
	
	band[i] = new TextLayer
		parent: songPages[i]
		text: songsInformation[i].band
		color: '#BBB'
		fontSize: 16
		fontWeight: 600
		x: Align.center
		y: 30

# 当页面发生变动时，切换歌曲信息
covers.on "change:currentPage", ->
	currentIndex = covers.horizontalPageIndex(covers.currentPage)
	songs.snapToPage(songPages[currentIndex])
