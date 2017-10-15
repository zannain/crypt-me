var AllAlerts = React.createClass({
	getInitialState() {
		return { alerts: [] }
	},
	componentDidMount() {
		console.log('mounted');
		$.getJSON('https://api.coinmarketcap.com/v1/ticker/?limit=10', (response) => { this.setState({ alerts: response }) });
	},
	render() {
		var alerts = this.state.items.map((alert) => {
			return (
				<div>
					<td>{alert.rank}</td>
					</div>
					)
		});
		return(<div>{alerts}</div>)
	}
})