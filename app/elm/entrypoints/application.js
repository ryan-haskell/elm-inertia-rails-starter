import { createInertiaApp } from 'elm-inertia'
import Main from '../src/Main.elm'

if (import.meta.env.DEV) {
  // In development, print out data-page attribute
  try {
    let data = JSON.parse(document.getElementById('app').getAttribute('data-page'))
    console.info(data)
  } catch (err) {
    console.error(err)
  }
}

// 1. Start the Elm application
let app = createInertiaApp({
  node: document.getElementById('app'),
  init: Main.init,
  flags: {
    window: {
      width: window.innerWidth,
      height: window.innerHeight,
    }
  },
})

// 2. Register any custom ports here
app.ports.onFlagsDecodeError.subscribe(error => {
  if (import.meta.env.DEV) {
    console.error(`FLAGS ERROR\n\n`, error)
  } else {
    // In production, report this error to Sentry etc
  }
})