# My Face

A Garmin Connect IQ watch face.

## Description

This is a watch face I built for my Vivoactive 4S. The main focus was performance and the obvious trade-off was code readability. Some of the performance tweaks are fairly reasonable while other tweaks are borderline psychotic.

In no particular order:

- Avoiding XML layouts.
- Avoiding watch face settings.
- Avoiding expensive Monkey C functionality: globals, switch statements, data types such as arrays or dictionaries, long function stacks, etc.
- Rendering the bare minimum during the night (hours and minutes is enough)
- Caching data that rarely changes like the date complication: It is only computed on the `onShow()` function as well as midnight (only time when it should change).
- Avoiding images (battery icon and move bar are done with dc calls)

## Performance

Memory usage sits extremely low at 11.6kB and peak usage at 12.5 kB (limit is ~500kB). The benchmarks of the `onUpdate()` function on a real-device also show that the watch face is CPU efficient.

## License

MIT
