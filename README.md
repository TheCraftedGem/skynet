# Welcome To Skynet

This application uses elixir OTP principles, DynamicSupervisors and Genservers are used to create processes that run concurrently. 

### Using the App
To Run This Program First Load Up The Files By Running The Following Command From The Root Directory Of The Project

`iex -S mix`


To Start The Program Run:

`Skynet.create_terminator`

This will start the first terminator. I have left in messages that output to the terminal when certain actions occur these messages will be one of following every 5-10 seconds.

`Termimator Created`

`Termiated Failed To Create`

`Terminator Killed!`

`Termiated Survives`

I left these in so that you could see when processes where being spawned or terminatedl. If you're manually testing the server via iex these can be a pain, so I recommend commenting these messages out, they're all inside the Terminator Module. 

To See Count Of Active Terminator Processes: 

`run Skynet.terminator_count`

To Kill A Terminator Process, I recommend setting the create_terminator function to a variable and passing that variable to the kill_terminator function. For example:

`{:ok, pid} = Skynet.create_terminator`

Followed by
`Skynet.kill_terminator(pid)`

To See A List Of The Terminators, After You Create The First Terminator Simply Run:

`Skynet.list_terminators`

Again I HIGHLY Recommend Commenting Out The Display Messages In The Terminator Module.

**My Thoughts On This Challenge**

I went through a couple variations, at first I started with agents but then switched to genservers because it seemed easier to manage. I would have wanted to test out the probability of the probability of the reproduce, and killed functions. I was thinking I could test that 5 seconds after a function was run that it ran the killed? or reproduce function. Something like the following. 

`test = self()
fun = fn -> send(test, :ran) end
 initiate task with fun
refute_receive :ran, :timer.seconds(x)
assert_receive :ran`

I had a lot of fun with this challenge, if I had more time I would have tested abit more, and gotten rid of the if statements in my Terminator Module. I think they make the code harder to follow, but my concerns on this challenge was to get it working first and if I had time make it look pretty. 



