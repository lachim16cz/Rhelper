# Rhelper
It is basic chat addon which add few more chat commands to start counters for Break or Pull.

## Game version
World of Warcraft: Wrath of the Lich King (3.3.5a)

## Commands
```
/pull <seconds | 0-300>
/break <minutes | 0-60>
/rclear
/rinfo
```

## How it works?
For example, you can write to your chat: **/pull 20**

Addon will count in 20 seconds pull timer to /rw like that:
```
Pull in 20
Pull in 15
Pull in 10
Pull in 7
Pull in 5
Pull in 4
Pull in 3
Pull in 2
Pull in 1
>> Pull NOW <<
```

If you want raid break, you can write /break 5

Addon will announce in /rw that players have 5 minutes break time. There is chat output:
```
The break time started, you have 5 minute(s)
The break time ends in 3 minutes
The break time ends in 1 minute
The break time ends in 30 seconds
Break time is over!
```

So it is almost same as DBM :)

## Known problems
- If you minimize the game, the timer pauses.

## Update 1.2
- The Rhelper will now show you a simple frame with time which you can move to your best position.

## Update 1.1
- Addon now communicates with DBM.
