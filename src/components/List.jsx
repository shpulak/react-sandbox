var React = require('react');
var ListItem = require('./ListItem.jsx');

var cars = [{ 'id':1,'title':'Audi'},{ 'id':2,'title':'BMW'},{ 'id':3,'title':'Mercedes-Benz'}];

var List = React.createClass({
    render : function(){
        var listItems = cars.map(function(car){
            return <ListItem key={car.id} title={car.title} />;
        });
        return (<ul>{listItems}</ul>);
    }
});

module.exports = List;