# Create layers
screenA = new Layer
	size: Screen.size
	backgroundColor: "#00AAFF"

screenB = new Layer
	size: Screen.size
	backgroundColor: "#FFCC33"

# Set up FlowComponent
flow = new FlowComponent
flow.showNext(screenA)

# Switch on click
screenA.onClick ->
	flow.showNext(screenB)

screenB.onClick ->
	flow.showPrevious()

