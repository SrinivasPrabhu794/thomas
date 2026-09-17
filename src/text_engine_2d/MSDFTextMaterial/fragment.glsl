varying vec2 vUv;

uniform float uOpacity;
uniform float uOffset;
uniform vec3 uColor;
uniform sampler2D uMap;

// Three.js clipping support — declares clippingPlanes[] uniform + vClipPosition varying
#include <clipping_planes_pars_fragment>

float median(float r, float g, float b) {
    return max(min(r, g), min(max(r, g), b));
}

void main() {
    // Discard fragments outside the active clipping volume first — skips the MSDF
    // sample + derivative work for fragments we're throwing away anyway.
    #include <clipping_planes_fragment>

    vec3 s = texture2D(uMap, vUv).rgb;
    float sigDist = median(s.r, s.g, s.b) - 0.5 + uOffset;

    float alpha = clamp(sigDist / fwidth(sigDist) + 0.5, 0.0, 1.0);
    if (alpha < 0.01) discard;

    gl_FragColor = vec4(uColor, uOpacity * alpha);
}
