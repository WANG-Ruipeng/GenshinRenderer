Shader "NightsoulOutlineSimple"
{
    Properties
    {
        _OutlineColor ("Outline Color", Color) = (1,0,0,1) // 默认红色便于观察
        _OutlineWidth ("Outline Width", Range(0,1)) = 0.01 // 默认很小的值
    }
    SubShader
    {
        Tags { 
            "RenderPipeline" = "UniversalRenderPipeline" 
            "RenderType" = "Opaque" 
        }
        LOD 100

        Pass
        {
            Name "Outline"
            
            Cull Front // 只渲染背面

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS : NORMAL;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
            };

            CBUFFER_START(UnityPerMaterial)
                float4 _OutlineColor;
                float _OutlineWidth;
            CBUFFER_END

            Varyings vert(Attributes input)
            {
                Varyings output;
                
                // 将法线转换到世界空间
                float3 normalWS = TransformObjectToWorldNormal(input.normalOS);
                // 将顶点转换到世界空间
                float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
                // 沿法线方向扩展顶点
                positionWS += normalWS * _OutlineWidth;
                // 转换到裁剪空间
                output.positionHCS = TransformWorldToHClip(positionWS);
                
                return output;
            }

            half4 frag(Varyings input) : SV_Target
            {
                return _OutlineColor;
            }
            ENDHLSL
        }
    }
}