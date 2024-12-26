wasm = { env: { console: (s, l) => {
  let utf8 = new TextDecoder("utf-8")
  let array = new Uint8Array(wasm.mem.buffer, s, l)

  console.log(utf8.decode(array))
}}}

window.onload = function() {
  if (!("WebAssembly" in window))
    alert("missing wasm support!")

  WebAssembly.instantiateStreaming(fetch("./hello.wasm"), wasm).then(
    obj => {
      wasm.mem = obj.instance.exports.memory
      obj.instance.exports.load()
    }
  )
}
