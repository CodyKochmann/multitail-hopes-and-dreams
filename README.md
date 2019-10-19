# multitail-hopes-and-dreams

### Problem

> There are quite a few containers that have hidden logs in their file system that aren't directed to stdout. While this isn't wrong, it doesn't mean stdout only has to be wrong either.

### Solution

> What if a dockerfile's stdout was a labeled stream of log events effectively giving both introspection into the container AND a fully sequential stream of events to be able to monitor interactions of different log files?

### Notes

While a 100% full auto solution would be something that autodetects log files and starts logging them, thats a moonshot compared to all I would like to do.

#### What would I like to make?

I would like to build a script that acts as an entrypoint wrapper to a docker container (or any command really) that has an invocation like the following.

```bash
watch-logs-and-run /path/to/1.log /path/to/2.log /weird/deep/path/to/side-effect.log -- /usr/bin/get-food --fast --maybe waffles
```

#### What would this scripts output look like?

```
2019/10/19 12:10:30 get-food - Imma startin up!
2019/10/19 12:10:31 get-food - Oh, gotta make some waffles
2019/10/19 12:10:31 1.log - waffle-iron-core plugged in. Welcome back!
2019/10/19 12:10:32 1.log - waffle-iron-core preheating...
2019/10/19 12:10:32 get-food - gonna get the ingredients ready
2019/10/19 12:10:32 2.log - open cabinet[1] detected
2019/10/19 12:10:32 2.log - open cabinet[2] detected
2019/10/19 12:10:32 2.log - open cabinet[4] detected
2019/10/19 12:10:33 get-food - where the **** is it
2019/10/19 12:10:33 side-effect.log - kitchen mood levels modified: old[HUNGRY] new[HANGRY]
2019/10/19 12:10:34 get-food - screw it I want pop tarts
2019/10/19 12:10:35 1.log - waffle-iron-core unplugged. Feeling sleepy...
2019/10/19 12:10:36 2.log - open cabinet[7] detected
.
.
.
```

#### How could this be done?

I think multitail can do it. But I am starting to give up due to:

- how difficult it has been to get it to stream everything in one labeled and timestamped stream
- multitail doesn't seem to know how to close when the main command its following stops
- multitail's output doesn't seem to be picked up by dockers log collection even though its all stdout based.

Backup plan is reinvent multitail in go... I don't wanna reinvent. But want this more than I don't wanna do that.

Help?
