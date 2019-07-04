Shader "Unlit/GifShader"
{
    Properties
    {
        _Textures   ("Textures",    2DArray) = "white" {}
        _FrameCount ("Frame Count", Int)     = 0
        _AnimSpeed  ("Anim Speed",  Float)   = 5
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
        }

        Pass
        {
            CGPROGRAM

            #pragma vertex   vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float4 uv     : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv     : TEXCOORD0;
                float  id     : TEXCOORD1;
            };

            UNITY_DECLARE_TEX2DARRAY(_Textures);
            float4 _Textures_ST;

            int   _FrameCount;
            float _AnimSpeed;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _Textures);
                o.id = v.uv.z;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                int frameIndex = (_Time.y + i.id) * _AnimSpeed % _FrameCount;

                fixed4 color  = UNITY_SAMPLE_TEX2DARRAY(_Textures, float3(i.uv.xy, frameIndex));

                if(color.a == 0) discard;

                return color;
            }

            ENDCG
        }
    }
}
