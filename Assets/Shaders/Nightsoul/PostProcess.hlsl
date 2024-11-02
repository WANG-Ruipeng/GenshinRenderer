
void OutlineSample_float(
    Texture2D MainTex,
    SamplerState SS,
    float2 UV,
    float2 TexelSize,
    float2 Distort,
    out float OutlineAlpha)
{
    float2 destUv = TexelSize + Distort;

    float spriteLeft = MainTex.Sample(SS, UV + float2(destUv.x, 0)).a;
    float spriteRight = MainTex.Sample(SS, UV - float2(destUv.x, 0)).a;
    float spriteBottom = MainTex.Sample(SS, UV + float2(0, destUv.y)).a;
    float spriteTop = MainTex.Sample(SS, UV - float2(0, destUv.y)).a;
    float spriteTopLeft = MainTex.Sample(SS, UV + destUv).a;
    float spriteTopRight = MainTex.Sample(SS, UV + float2(-destUv.x, destUv.y)).a;
    float spriteBotLeft = MainTex.Sample(SS, UV + float2(destUv.x, -destUv.y)).a;
    float spriteBotRight = MainTex.Sample(SS, UV + float2(-destUv.x, -destUv.y)).a;

    OutlineAlpha = spriteLeft + spriteRight + spriteBottom + spriteTop +
        spriteTopLeft + spriteTopRight + spriteBotLeft + spriteBotRight;
}