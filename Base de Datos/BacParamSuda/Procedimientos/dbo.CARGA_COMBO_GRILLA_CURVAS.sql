USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[CARGA_COMBO_GRILLA_CURVAS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[CARGA_COMBO_GRILLA_CURVAS]  
   (   @iColumna       INTEGER  
   ,   @cSistema       CHAR(3)     = ''  
   ,   @cProducto      VARCHAR(5)  = ''  
   ,   @cInstrumento   VARCHAR(20) = ''  
   ,   @iMoneda        INTEGER     = 0  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   IF @iColumna = 0  
   BEGIN  
      SELECT nombre_sistema , id_sistema FROM BacParamSuda..SISTEMA_CNT with (nolock) WHERE operativo = 'S' AND gestion = 'N' ORDER BY nombre_sistema  
   END  
  
   IF @iColumna = 1  
   BEGIN  
      SELECT descripcion , codigo_producto FROM BacParamSuda..PRODUCTO with (nolock) WHERE id_sistema = @cSistema  
   END  
  
   IF @iColumna = 2  
   BEGIN  
      IF @cSistema = 'BEX'   
      BEGIN  
         SELECT mnnemo , mncodmon FROM MONEDA with (nolock) WHERE mnmx = 'C' ORDER BY mncodmon  
      END ELSE  
      BEGIN  
         IF @cSistema = 'BFW' AND @cProducto = ''  
         BEGIN  
            SELECT mnnemo , mncodmon FROM MONEDA with (nolock) WHERE (mntipmon = 2) OR mncodmon IN(998,999)  
            RETURN  
         END  
          
         IF @cSistema = 'BFW' AND @cProducto = '10'
         BEGIN
            SELECT mnnemo , mncodmon FROM MONEDA with (nolock) WHERE mncodmon IN(998,999)
            RETURN
         END


         IF @cSistema = 'OPT' -- AND @cProducto = ''
         BEGIN
            SELECT mnnemo , mncodmon FROM MONEDA with (nolock) WHERE mncodmon IN(999, 13)
            RETURN
         END

        
         SELECT mnnemo , mncodmon FROM MONEDA with (nolock) WHERE mncodmon = 13  
         UNION  
         SELECT mnnemo , mncodmon  
         FROM   PRODUCTO_MONEDA  with (nolock)  
                LEFT JOIN MONEDA with (nolock) ON mncodmon = mpcodigo  
         WHERE  mpsistema = @cSistema AND mpproducto = @cProducto  
         ORDER BY mncodmon  
      END  
   END  
  
   IF @iColumna = 3  
   BEGIN  
      IF @cSistema = 'BEX'  
      BEGIN  
         SELECT Nom_Familia , Cod_familia , 0 FROM BacBonosExtSuda..TEXT_FML_INM with (nolock) ORDER BY Nom_Familia  
      END  
  
      IF (@cSistema = 'BTR') or (@cSistema = 'BFW' and @cProducto = '10')  
      BEGIN  
         SELECT inserie , incodigo , inrutemi FROM BacParamSuda..INSTRUMENTO with (nolock) ORDER BY inserie  
      END  
  
      IF @cSistema <> 'BEX' AND @cSistema <> 'BTR'  
      BEGIN  
         SELECT '' , '' , ''   
      END  
   END  
  
   IF @iColumna = 4  
   BEGIN  
      IF @cSistema = 'BTR' AND @cInstrumento = 'LCHR'  
      BEGIN  
         SELECT emnombre , emgeneric FROM EMISOR with (nolock) ORDER BY emnombre  
      END  
   END  
  
   IF @iColumna = 8  
   BEGIN  
      IF @cSistema = 'PCS'  
      BEGIN  
         SELECT Glosa, Codigo FROM BacSwapSuda..BASE with (nolock)  
      END  
   END  
  
   IF @iColumna = 13  
   BEGIN  
      SELECT tbglosa, tbcodigo1, tbcodigo1  
      FROM   BacparamSuda..TASAS_MONEDA       with (nolock)  
             INNER JOIN TABLA_GENERAL_DETALLE with (nolock) ON tbcateg = 1042 AND Codigo_Tasa = tbcodigo1  
      WHERE  Codigo_Moneda = @iMoneda  
    --> AND    Codigo_Tasa  <> CASE WHEN @cProducto = 'SP' THEN -1 ELSE 13 END --> Se Saco por problemas en Filtro para tasa ICP.  
      ORDER BY tbglosa  
   END  
  
END  
GO
