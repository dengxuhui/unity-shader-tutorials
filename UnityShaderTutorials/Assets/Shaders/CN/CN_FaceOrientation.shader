Shader "CN/Unlit/Face Orientation"{
    Properties{
        _ColorFront("Front Color",Color) = (1,0.7,0.7,1)
        _COlorBack("Back Color",Color) = (0.7,1.0,0.7,1)
    }

    SubShader{
        Pass{
            Cull Off//关闭背面剔除

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            float4 vert(float4 vertex : POSITION):SV_POSITION{
                return UnityObjectToClipPos(vertex);
            }
            fixed4 _ColorFront;
            fixed4 _COlorBack;
            fixed4 frag(fixed facing : VFACE):SV_Target{
                return facing > 0 ? _ColorFront : _COlorBack;
            }
            ENDCG
        }
    }
}