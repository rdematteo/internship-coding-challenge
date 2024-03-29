# Internship Coding Challenge
## Zendesk Ticket Viewer
<hr>

### 1. Framework
Sinatra (2.0.5)

<hr>

### 2. Dependencies
Ruby gems list includes:
- sinatra (2.0.5)
- sinatra-contrib (2.0.5) - need this to run sinatra/json
- http (4.1.1)
- dotenv (2.7.2)

For testing
- rspec (3.8.0)
- webmock (3.6.0)

<hr>

### 3. Installation
Copy all files into a new directory.  
From the command line type: 
```
ruby ticket_viewer.rb  
```
The Sinatra server will start.  
In a new browser window type: 
```
localhost:4567
```   

<hr>

### 4. Authentication details
 have used HTTP gem to call the API and provide basic authentication.  
 In the HTTP get request I have utilized the dotenv gem to hide authentication details. The dotenv gem loads environment variable from the .env file into ENV variables to use in the application.  
 Throughout the majority of the challenge, I have placed the .env file in the .gitignore file. For the submission process I have removed the .env file from the .gitignore file, so you will be able to run the application. 

<hr>

### 5. USAGE 
### 5.1 Landing page
http://localhost:4567/
![landing_page](https://user-images.githubusercontent.com/47741682/59166339-ea4a2500-8b6b-11e9-8a27-322173f77f27.png)

Assumptions:  
1.   As the requirement was "Request the tickets for your account" i have used the following endpoint; 
```
GET /api/v2/tickets.json
```
as per https://developer.zendesk.com/rest_api/docs/support/tickets  
This query will return a maximum of 100 tickets.  
For a more dynamic approach, the integration of search queries would have provided extra functionality.  This feature could easily be added using the Document Object Model(DOM).  

2.  "page through tickets when more than 25 are returned"  
As the request was to return 25 tickets per page I have created a landing page provides you with 4 options, each option directing you to a page displaying 25 tickets.  

On each of these pages you have the option to display the next or previous 25 tickets(per page).  

```
The landing page will open even when the API or the network connection is down.  
```

<hr>

### 6. Pagination
There are several gems that handle pagination (kaminari, will_paginate, pagy; https://www.ruby-toolbox.com/categories/pagination ) but all these required class objects to be created, which was outside the scope of my application. Although Zendesk docs have information regarding pagination (https://developer.zendesk.com/rest_api/docs/support/introduction#pagination) I could not interpret this information. Therefore, I implemented my own code for pagination.  
The pagination is hard coded to show 25 tickets per page but this can be changed to another number(if required - line 36; ticket_viewer.rb).  The pagination is dynamic, thus if a smaller number is inserted, the application will continue to display pages until the last ticket is displayed.  
I decided to list tickets as cards rather than a traditional un/ordered list. It provides a simple, clear, view of all the tickets.
![page_1](https://user-images.githubusercontent.com/47741682/59167238-99d6c580-8b73-11e9-8559-7335f2a023b4.png)  

**LIMITATION**: This approach may run into issues when there are more than 100 tickets in the account.

#### 6.1 Pagination: error handling
- Pages < 1
On page 1, the previous page button is hidden. In addition, if users were to type into url, a page number which is < 1 (i.e. http://localhost:4567/tickets?page=-4 ), the application will redirect to the first page.   
- Pages > than last page.   
A message appears "No more tickets to display"

<hr>

### 7. Error handling
#### 7.1 API down on landing page
When the API or network connection is down, two errors messages are triggered.
1. A message appears on the webpage.  
   Instead of redirecting to a 404 page, a message is presented to the user;  

   ![error_message](https://user-images.githubusercontent.com/47741682/59168812-c17d5c00-8b7a-11e9-9cf8-76c1b6c5d84d.png)  

   On line 42 of the code (ticket-viewer.rb) i have commented out a re-direct to a 404 page

2. A message also appears on the Sinatra server logs;  
   <img width="600" alt="api_down_landing" src="https://user-images.githubusercontent.com/47741682/59168851-f25d9100-8b7a-11e9-9521-57185b87065d.png">  

**The user can always redirect to the homepage.**

#### 7.2 API down on page view
The identical error message as in option 1 (above) will appear, however a different message appears in the Sinatra logs, indicating a redirect(302).  

<img width="612" alt="api_down_page" src="https://user-images.githubusercontent.com/47741682/59169601-4fa71180-8b7e-11e9-868c-a7e35a568ff1.png">

#### 7.3 See pagination:error handling section for error handling

#### 7.4 Incorrect url
If the user types in '/tickets/' or '/ticket' a 404 page is presented advising users of the correct url and links to the correct url.

<hr>

### 8. Testing
The hardest part of the challenge!  
I had two choices; MiniTest or RSpec. I went with RSpec, as there were slightly more docs.  
I have complete three sets of testing.  
1. Integration testing  
  run: `rspec ticket_viewer_spec.rb` ; located in the parent directory.  
  These tests determine that the API is working and returns appropriate status codes, correct routing (happy paths), and a test on pagination error handling.  
  I have also had a go at using a spy (test 6), bit I am not sure if this is working correctly. 
2. Stub testing  
  run: `rspec ticket_viewer_stub_spec.rb` ; located in the parent directory. 
  I understand a stub will test the behavior of the application. I have included two tests, the first testing the response of body and the other testing the status code. The first test appears to work however I can't get the second test to work properly (even though it passes!!)
3. Fake testing  
   run: `rspec ticket_viewer_fake_spec.rb` ; located in /spec directory.  
   I have created a fake ticket (fake_data.json) and these tests check if the fake ticket contains specific data types, or contains specific data. 
4. Mock testing  
I did not undertake any mock testing. However a mock object is a fake object that’s used in place of a real object for the purpose of listening to the methods called on the mock object. 



<hr>

### 9. Design process.
All code was written in VS code.  
To connect to the Zendesk API, my initial choice was to use axios over the native Fetch, due to the asynchronous functioning with axios. After many hours, I had difficulty manipulating the returned object to work with it. I then discovered the Zendesk API gem and gave this a try. I was able to retrieve a collection from the API but was unable to manipulate the object. My next choice was to use HTTP and this worked very well. I was able to add username and password as basic authentication and I was able to parse the object into JSON to obtain a workable object. 

My next choice was the framework. I had two choices, Ruby on Rails(RoR) or Sinatra. Although RoR is a powerful RESTful solution, implementing this challenge on Sinatra was the perfect solution for me as it is a lightweight Ruby web framework.  

As requested, the design was simple and minimal but very user friendly. I hope you enjoy looking over the application as much as i have enjoyed creating it!

Robert De Matteo.  
June 2019.


