#include "UnityCG.cginc"

sampler2D _MainTex;
half4 _MainTex_ST;

//  颜色
#if COLOR_ON
    half4 _Color;
    half _Brightness;
    half _Contrast;
#endif

#if PHONG_ON
    //uniform 标识为只读变量
    uniform half4 _PointLightColor;
    uniform half3 _PointLightPosition;

    half _AmbiencePower;
    half _SpecularPower;
    half _DiffusePower;
#endif


#if DETAIL_ON
    sampler2D _DetailMap;
    half _DetailStrength;
#endif

#if DETAIL_ON && DETAIL_MASK_ON 
    sampler2D _DetailMask;
#endif

#if EMISSION_ON
    sampler2D _EmissionMap;
    half _EmissionStrength;
#endif

#if NORMAL_ON
    sampler2D _NormalMap;
#endif

struct appdata{
    float4 vertex : POSITION;
    half2 texcoord : TEXCOORD0;
    #if PHONG_ON
        float4 normal : NORMAL;
    #endif
    #if NORMAl_ON
        float4 tangent : TANGENT;
    #endif
};

struct v2f{
    float4 vertex : SV_POSITION;
    half2 uv_main : TEXCOORD0;
    UNITY_FOG_COORDS(1)
    #if PHONG_ON
        float4 worldVertex : TEXCOORD2;
    #endif
    #if PHONG_ON || NORMAL_ON
        half3 worldNormal : TEXCOORD3;
    #endif
    // 切线空间3x3矩阵
    #if NORMAL_ON
        half3 tspace0 : TEXCOORD4;
        half3 tspace1 : TEXCOORD5;
        half3 tspace2 : TEXCOORD6;
    #endif
};


v2f vert(appdata v){
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    #if PHONG_ON
        o.worldVertex = mul(unity_ObjectToWorld,v.vertex);
        o.worldNormal = UnityObjectToWorldNormal(v.normal);
    #endif

    #if NORMAL_ON
        half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
        half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
        half3 wBitangent = cross(o.worldNormal,wTangent) * tangentSign;
        o.tspace0 = half3(wTangent.x,wBitangent.x,o.worldNormal.x);
        o.tspace1 = half3(wTangent.y,wBitangent.y,o.worldNormal.y);
        o.tspace2 = half3(wTangent.z,wBitangent.z,o.worldNormal.z);
    #endif

    o.uv_main = TRANSFORM_TEX(v.texcoord,_MainTex);
    UNITY_TRANSFER_FOG(o,o.vertex);
    return o;
}

fixed4 frag(v2f IN) : SV_TARGET{
    return fixed4(1.0,1.0,1.0,1.0);
}