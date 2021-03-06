USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLIENTES_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CLIENTES_SPOT]  
   (   @oMercado   CHAR(4)  
   ,   @iRut       NUMERIC(9)  = 0  
   ,   @iCodigo    NUMERIC(5)  = 0  
   ,   @oNombre    VARCHAR(50) = ''  
   ,   @Buscando   INTEGER     = -1  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   IF (@Buscando = -1 AND (@oMercado = 'PTAS' OR @oMercado = 'ARBI'))  
   BEGIN  
  
      SELECT clrut  
         ,   cldv  
         ,   clcodigo  
         ,   clnombre  
         ,   clvigente  
         ,   Bloqueado  
         ,   Mensaje = CASE WHEN clvigente = 'N' THEN 'Cliente No se encuentra vigente.'  
                            WHEN Bloqueado = 'S' THEN 'Cliente Se encuentra Bloqueado.'  
                            ELSE                      ''  
                       END  
         ,   Estado  = CASE WHEN clvigente = 'N' THEN -1  
                            WHEN Bloqueado = 'S' THEN -1  
                            ELSE                       0  
                       END  
        FROM BacParamSuda.dbo.CLIENTE  
       WHERE  cltipcli  <= 4  
         AND  clvigente = 'S'  
         AND (Bloqueado = 'N' or Bloqueado = '')  
         AND ( (clrut = @iRut and clcodigo = @iCodigo)  
             or(@iRut = 0     and @iCodigo = 0)  
             )  
         AND ( (clrut = @iRut and clcodigo = @iCodigo)  
             or(@iRut = 0     and @iCodigo = 0)  
             )  
         AND ( clnombre > @oNombre )  
    ORDER BY clnombre  
   END  
  
  
   IF (@Buscando = -1 AND (@oMercado = 'EMPR'))  
   BEGIN  
      SELECT clrut  
         ,   cldv  
         ,   clcodigo  
         ,   clnombre  
         ,   clvigente  
         ,   Bloqueado  
         ,   Mensaje = CASE WHEN clvigente = 'N' THEN 'Cliente No se encuentra vigente.'  
                            WHEN Bloqueado = 'S' THEN 'Cliente Se encuentra Bloqueado.'  
                            ELSE                      ''  
                       END  
         ,   Estado  = CASE WHEN clvigente = 'N' THEN -1  
                            WHEN Bloqueado = 'S' THEN -1  
                            ELSE                       0  
                       END  
        FROM BacParamSuda.dbo.CLIENTE  
       WHERE  cltipcli >= 4  
         AND  clvigente = 'S'  
         AND (Bloqueado = 'N' or Bloqueado = '')  
         AND ( (clrut = @iRut and clcodigo = @iCodigo)  
             or(@iRut = 0     and @iCodigo = 0)  
             )  
         AND ( clnombre > @oNombre )  
    ORDER BY clnombre  
   END  
  
   IF @Buscando = 1 --> Digita los Datos  
   BEGIN  
  
  DECLARE @iEspecial INT  
   SET @iEspecial = 0  
  
  IF (@iRut = 97023000 AND @iCodigo = 1) AND @oMercado = 'EMPR'  
   SET @iEspecial = 1  
  
      SELECT clrut  
         ,   cldv  
         ,   clcodigo  
         ,   clnombre  
         ,   clvigente  
         ,   Bloqueado  
         ,   Mensaje = CASE WHEN clvigente  = 'N'                      THEN LTRIM(RTRIM( SUBSTRING( clnombre, 1, 25))) + ' No se encuentra vigente.'  
                            WHEN Bloqueado  = 'S'                      THEN LTRIM(RTRIM( SUBSTRING( clnombre, 1, 25))) + ' Se encuentra Bloqueado.'  
                            WHEN @iEspecial = 1         THEN ''  
       WHEN @oMercado  = 'PTAS' AND cltipcli  > 4 THEN LTRIM(RTRIM( SUBSTRING( clnombre, 1, 25))) + ' No corresponde al Mercado.'  
                            WHEN @oMercado  = 'ARBI' AND cltipcli  > 4 THEN LTRIM(RTRIM( SUBSTRING( clnombre, 1, 25))) + ' No corresponde al Mercado.'  
                            WHEN @oMercado  = 'EMPR' AND cltipcli  < 4 THEN LTRIM(RTRIM( SUBSTRING( clnombre, 1, 25))) + ' No corresponde al Mercado.'  
                            ELSE                                           ''  
                       END  
         ,   Estado  = CASE WHEN clvigente = 'N'                      THEN -1  
                            WHEN Bloqueado = 'S'                      THEN -1  
                            WHEN @iEspecial = 1        THEN 0  
                            WHEN @oMercado = 'PTAS' AND cltipcli  > 4 THEN -1  
                            WHEN @oMercado = 'ARBI' AND cltipcli  > 4 THEN -1  
                            WHEN @oMercado = 'EMPR' AND cltipcli  < 4 THEN -1  
                            ELSE                                      0  
                       END  
      FROM  BacParamSuda.dbo.CLIENTE  
      WHERE ( (clrut = @iRut and clcodigo = @iCodigo)   
           or (@iRut = 0     and @iCodigo = 0)  
            )  
        AND ( ( clnombre LIKE LTRIM(RTRIM( @oNombre ))  + '%' )  
           or ( @oNombre = '')  
            )  
      ORDER BY clrut, clcodigo  
   END  
  
END

GO
