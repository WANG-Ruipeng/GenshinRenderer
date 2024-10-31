Shader "NightsoulOutlineSimple"
{
    Properties
    {
        _OutlineColor ("Outline Color", Color) = (1,0,0,1) // Ĭ�Ϻ�ɫ���ڹ۲�
        _OutlineWidth ("Outline Width", Range(0,1)) = 0.01 // Ĭ�Ϻ�С��ֵ
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
            
            Cull Front // ֻ��Ⱦ����

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
                
                // ������ת��������ռ�
                float3 normalWS = TransformObjectToWorldNormal(input.normalOS);
                // ������ת��������ռ�
                float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
                // �ط��߷�����չ����
                positionWS += normalWS * _OutlineWidth;
                // ת�����ü��ռ�
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