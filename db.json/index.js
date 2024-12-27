const express = require('express')
const cors = require('cors');
const app = express();
app.use(cors());

app.use(express.json());
const categories = [
  { 'id': 1,
    "name": "All Menu" 
  },
  { 'id' : 2,
    "name": "Paket Lion Tahu Metal" 
  },
  { 'id' : 3,
    "name": "Paket Bakmie / Pangsit LTM" 
  },
  {
    'id' : 4,
    'name' : 'Paket Soup Bakso LTM'
  },
  {
    'id' : 5,
    'name' : 'Paket Hupia / Fish Cake'
  },
  {
    'id' : 6,
    'name' : 'Seasonal Menu'
  },  
  {
    'id' : 7,
    'name' : 'Juice'
  },
  {
    'id' : 8,
    'name' : 'Frozen Pack'
  },
  {
    'id' : 9,
    'name' : 'Minuman'
  },
  {
    'id' : 10,
    'name' : 'Dessert LTM'
  },
]
const Menu = [
  [
    {
      "name": "Liong Tahu",
      "price": 55000,
      "description": "This burger is often served with cheese, lettuce, tomato, onion, pickles, bacon, or chilis; condiments such as ketchup, mustard, mayonnaise, relish, or a 'special sauce', often a variation of Thousand Island dressing; and are frequently placed on sesame seed buns."
    },
    {
      "name": "Bakmie LTM",
      "price": 45000,
      "description": "Delicious noodle dish served with a variety of toppings and sauces."
    },
    {
      "name": "Bakso LTM",
      "price": 30000,
      "description": "Savory meatballs served with soup and condiments."
    },
    {
      "name": "Fish Cake",
      "price": 25000,
      "description": "Tasty fish cakes made from fresh fish and spices."
    },
    {
      "name": "Seasonal Special",
      "price": 70000,
      "description": "A special menu item available for a limited time only."
    }
  ]
  
]

  app.get('/categories', (req, res) => {
    res.json(categories); 
  });

  app.get('/menu', (req, res) => {
    res.json(Menu); 
  });
  

  app.listen(3000,() => {
    console.log("Server is running on port 3000");
  });
  