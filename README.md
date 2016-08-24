#Global timer 

#This is a timer user block, you can use it anywhere in your project, and stop it in another View or VIewController.

#Support to add timer with key.

#You can you it like This:

[NSTimer scheduledTimerWithInterval:1 repeats:YES block:^{
   //code here
}];

#Or use it with key:

[NSTimer scheduledTimerWithKey:@"a custom key" Interval:1 repeats:YES block:^{
  //code here
}];
