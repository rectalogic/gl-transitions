// Author: Andrew Wason
// License: MIT

uniform sampler2D lumaTex;
uniform bool invertLuma; // = false;
uniform float softness; // = 0.0;

// Port of rendermix wipe transition
// https://github.com/rectalogic/rendermix-basic-effects/blob/master/assets/com/rendermix/Wipe/Wipe.frag
vec4 transition(vec2 uv) {
    vec2 p = uv.xy / vec2(1.0).xy;

    float luma = texture2D(lumaTex, p).x;
    if (invertLuma)
        luma = 1.0 - luma;
    vec4 fromColor = getFromColor(p);
    vec4 toColor = getToColor(p);
    float time = mix(0.0, 1.0 + softness, progress);
    if (time == 0.0)
        return fromColor;
    else if (luma <= time - softness)
        return toColor;
    else if (luma >= time)
        return fromColor;
    else {
        float alpha = (time - luma) / softness;
        return mix(fromColor, toColor, alpha);
    }
}
