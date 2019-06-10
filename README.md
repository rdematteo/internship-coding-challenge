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

### Running the application
Copy all files into a new directory.  
From the command line type: ruby ticket_viewer.rb  
The Sinatra server will start.  
In a new browser window type: localhost:4567 and enter.  

### Authentication details.
In the HTTP get request I have used dotenv to hide my authentication details. Throughout the majority of the challenge, I have placed the .env file in the .gitignore file. For the submission process I have removed the .env file from the .gitignore file, so you will be able to run the application. 

### Landing page.
http://localhost:4567/
![landing_page](https://user-images.githubusercontent.com/47741682/59166339-ea4a2500-8b6b-11e9-8a27-322173f77f27.png)

Assumptions:  
1.   
As the requirement was "Request the tickets for your account" i have used the following endpoint 
```
GET /api/v2/tickets.json
```
as per https://developer.zendesk.com/rest_api/docs/support/tickets  
This query will return a maximum of 100 tickets.  
For a more dynamic approach, the integration of search queries would have provided extra functionality.  This feature could easily be added using the Document Object Model(DOM).  
2.  
"page through tickets when more than 25 are returned"  
As the request was to return 25 tickets per page I have created a landing page provides you with 4 options, each option directing you to a page displaying 25 tickets.  

On each of these pages you have the option to display the next or previous 25 tickets(per page).  

```
The landing page will open even when the API or the network connection is down.  
```
### Pagination
There are several gems that handle pagination (kaminari, will_paginate, pagy; https://www.ruby-toolbox.com/categories/pagination ) but all these required class objects to be created, which was outside the scope of this application. Although Zendesk docs have information regarding pagination (https://developer.zendesk.com/rest_api/docs/support/introduction#pagination) I could not make interpret this information. Therefor, I implemented code for pagination.  
It is hard coded to show 25 tickets per page but this can be changed to another integer.  The pagination is dynamic, thus if a smaller integer is inserted, the application will continue to display pages until the last ticket is displayed.  
I decided to list tickets as cards rather than a traditional un/ordered list. It provides a simple, clear, view of all the tickets.
![page_1](https://user-images.githubusercontent.com/47741682/59167238-99d6c580-8b73-11e9-8559-7335f2a023b4.png)

#### Pagination: error handling
- Pages < 1
On page 1, the previous page button is hidden. In addition, if users were to type into url, a page number which is < 1 (i.e. http://localhost:4567/tickets?page=-4 ), the application will redirect to the first page.   
- Pages > than last page.   
A message appears "No more tickets to display"




### Design process.
All code was written with VS code to write.  
To connect to the Zendesk API, my initial choice was to use axios over the native Fetch, due to the asynchronous functioning with axios. After many hours I had difficulty manipulating the returned object to work with it. I then discovered the Zendesk API gem and gave this a try. I was able to retrieve a collection from the API but was unable to manipulate the object. My next choice was to use HTTP and this worked very well. I was able to add username and password as basic authentication and I was able to parse the object into JSON to obtain a workable object. 

My next choice was the framework. I had two choices, Ruby on Rails(RoR) or Sinatra. Although RoR is a powerful RESTful solution, implementing this challenge on Sinatra was the perfect solution for me as it is a lightweight Ruby web framework.  


