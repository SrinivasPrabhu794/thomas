varying vec2 vUv;

// Three.js clipping support — declares vClipPosition varying when NUM_CLIPPING_PLANES > 0
#include <clipping_planes_pars_vertex>

void main() {
    vec4 mvPosition = vec4(position, 1.0);
    mvPosition = modelViewMatrix * mvPosition;
    gl_Position = projectionMatrix * mvPosition;

    vUv = uv;

    // Writes vClipPosition from mvPosition for the fragment-side clip test
    #include <clipping_planes_vertex>
}
