# Chess
A ruby terminal Chess game.

### Controls 

* Arrow keys to move
* Enter to select spaces

## Technologies 

* Ruby

## Features 

### Realistic High-Speed Movement

In order to achieve realistic high-speed illusory movement (like car wheels on a highway appearing to move slowly)
it was necessary for me to use the modulo operator when resetting the position of the rendered planes.

```javascript
if ( orbitPos.z > nearPlane ) {
  orbitPos.z = farPlane + ( orbitPos.z % nearPlane );
.
.
.
if ( orbitPos.z < nearPlane ) {
  orbitPos.z = nearPlane + ( orbitPos.z % farPlane );
.
.
.
```

### Big Bang Animation

In order to simulate a big bang the camera FOV starts at 180˚ and animates downward to a randomized parameter.
I played around with different decrement methods to make the animation as smooth as possible.

```javascript 
function decrementFov(decrement) {
  camera.fov -= decrement;
  camera.updateProjectionMatrix();
}

function decrementFovToFinalFov() {
  if ( camera.fov > finalFov * 2.5 ) {
    decrementFov(0.3);
  } else if (camera.fov > finalFov) {
    decrementFov( (camera.fov * (camera.fov / 10))  / (360 * 36) );
  } else {
    clearInterval( fovDecrementInterval );
    cosmicInception = false;
  }
}
.
.
.
function animateNewSceneFov() {
  fovDecrementInterval = setInterval( decrementFovToFinalFov, 6 );
}
```
