# Review TriviaFlop code
App TriviaFlop made by Dennis Broekhuizen reviewed by Bob Hamelers.

## 1 Names
#### Aspect of code quality
Level 4

Overall all used names of functions or variables are very clear of what they do.

#### Where in your code are examples of good/bad quality
For example the names used in file QuestionViewController makes the flow of the file really understandable. You can really imagine what activities happen after each other.

#### How to improve next time
Some names could be a little more specific, but it doesn't bother me very much. For example 'counter' in file QuestionViewController is a clear name, but you could also call it quizTimer or quizCounter, because that's what it's used for. By the way, you could also rename the first 'viewController' name. That makes it a little bit more clear for which screen it's used for.


## 2 Headers
#### Aspect of code quality
Level 2

Standard headers are present, but you could give a short summary of what the file does. In some headers you added a link of websites or videos you used for creating your app, that's a good thing.

#### Where in your code are examples of good/bad quality
Throughout the whole program you could a summaries.

#### How to improve next time
The summaries weren't finished at the moment of reviewing, so keep that in mind next time.


## 3 Comments
#### Aspect of code quality
Level 4

The comments really increases the quality of your code. It makes it a lot more understandable. It think there's also a great balance between the amount of comments. For me it's not too much or the other way around.

#### Where in your code are examples of good/bad quality
The files with the most code do have the most comments. It gives you a good description of what's happening.

#### How to improve next time
Overall I have nothing really important to add on this topic. Keep on going the way you're doing right now.


## 4 Layout
#### Aspect of code quality
Level 3

Really proper layout. All files are placed in separate folders. The order of code in files is also organized. First you show variables and constants, after that outlets, following by functions and actions.

#### Where in your code are examples of good/bad quality
For example QuestionViewController is a really big file in your app, but the flow is clear for me by the way you are ordering your functions.

#### How to improve next time
Maybe you could rearrange the order of some functions in a way of functions that are happing first in your app, but that's not a big deal for me. In most of the files you already did that.


## 5 Formatting
#### Aspect of code quality
Level 4

The way you format your code is just by the way we learned it, so I have nothing to add on that.

#### Where in your code are examples of good/bad quality
All of your code looks clean for me.

#### How to improve next time
Keep on going.


## 6 Flow
#### Aspect of code quality
Level 4

Just as I have mentioned before the flow is also clear for me. Maybe you could add some parts of your code in a separate function, but that could also make it less clear. BetterCodeHub gives you a good score, so I think you could keep it the way you are doing it right now.

#### Where in your code are examples of good/bad quality
QuestionViewController has a lot of code but the indent makes it readable.

#### How to improve next time
Keep on going.


## 7 Idiom
#### Aspect of code quality
Level 4

Good use of third party podfiles like SwiftySounds and HTMLString.

#### Where in your code are examples of good/bad quality
Used sounds with SwiftySound in some views. Really clear library in the way you can play a sound in your file.

#### How to improve next time
Nothing really I think.


## 8 Expressions
#### Aspect of code quality
Level 4

I don't see any warning in your Xcode, so at first sight I think you managed your expressions in a good way. Overlooking your code I can conclude the same. Made use of most of the expressions that are also teached in the book we worked with.

#### Where in your code are examples of good/bad quality
Used guard lets or if lets in a good way to unwrap thing in a save way.

#### How to improve next time
Didn't use really long expressions or anything like that. Using guard let's makes your code more readable, so keep on doing that.


## 9 Decomposition
#### Aspect of code quality
Level 4

Can't find much variables that are shared in more functions.

#### Where in your code are examples of good/bad quality
UpdateUI in QuestionViewController do have some tasks to perform, but I think they are all essential for the usage of your app so you can't really change that.

#### How to improve next time
Make you can find a way shorten some functions, right now most of the things are essential as said before.


## 10 Modularization
#### Aspect of code quality
Level 3

Using different functions to perform separate tasks is a good thing.

#### Where in your code are examples of good/bad quality
QuestionViewController has a lot of functions, but all separated in a good way.

#### How to improve next time
Maybe you could split updateUI in some functions, but for now it isn't a big deal.
