# Internship Coding Challenge
## Zendesk Ticket Viewer
<hr>

### Framework
Sinatra (2.0.5)
### Dependencies
Ruby gems list includes
- sinatra (2.0.5)
- sinatra-contrib (2.0.5) - need this to run sinatra/json
- http (4.1.1)
- dotenv (2.7.2)

For testing
- rspec (3.8.0)
- webmock (3.6.0)

<hr>

### Design process.
I have used VS code to write all my code.
To connect to the Zendesk API, my initial choice was to use axios over the native Fetch API. After many hours I had difficulty manipulating the returned object to work with it. I then dicoverd the ZeDesk API gem and gave this a try. I was able to retrieve a collection from the API but was unable to manipulate the object. My next choice was to use HTTP and this worked very well. I was able to add username and password as basic authentication and I was able to parse the object into JSON to obtain a workable object. 

My next choice was the framework. I had two choices, Ruby on Rails(RoR) and sinatra. Although RoR is a powerful RESTful solution, implementing this challenge on sinatra was the perfect solution for me.

