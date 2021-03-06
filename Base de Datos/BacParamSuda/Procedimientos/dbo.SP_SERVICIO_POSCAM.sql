USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SERVICIO_POSCAM]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_SERVICIO_POSCAM]
   (   @dFecha       DATETIME
   ,   @iOperacion   NUMERIC(9)
   ,   @Enviado      CHAR(1)    = 'N'
   ,   @Anulación    CHAR(1)    = 'N'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound  INTEGER
   DECLARE @iEstado CHAR(1)

   IF @Anulación = 'S'
   BEGIN
      SET    @iFound      = 0
      SELECT @iFound      = 1
      ,      @iEstado     = Estado
      FROM   dbo.MERCADO_CAMBIARIO 
      WHERE  OperacionBac = @iOperacion 

      IF @iFound = 1
      BEGIN
         IF @iEstado = 'P'
         BEGIN
            DELETE dbo.MERCADO_CAMBIARIO WHERE OperacionBac = @iOperacion
            RETURN
         END
      END
   END


   IF @Enviado = 'V'
   BEGIN
      IF ( SELECT MercadoCambiario FROM dbo.MERCADO_CAMBIARIO WHERE OperacionBac = @iOperacion ) = 0
      BEGIN
         SELECT -1, 'Mercado no definido.'
         RETURN
      END
      SELECT 0, 'Operacion se puede enviar.'
      RETURN
   END

   IF @Enviado = 'S'
   BEGIN
      UPDATE dbo.MERCADO_CAMBIARIO 
      SET    Estado       = CASE WHEN @Anulación = 'S' THEN 'A' ELSE 'E' END
      WHERE  OperacionBac = @iOperacion

      RETURN
   END

   DECLARE @iHora   CHAR(6)
   SET     @iHora   = REPLACE(CONVERT(CHAR(8),GETDATE(),108),':','')

   DECLARE @iFecha  CHAR(8)
   SET     @iFecha  = CASE WHEN DATEPART(HOUR,GETDATE())   <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(HOUR,  GETDATE()))
                           ELSE                                            CONVERT(CHAR(2),DATEPART(HOUR,  GETDATE()))
                      END +
                      CASE WHEN DATEPART(MINUTE,GETDATE()) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(MINUTE,GETDATE()))
                           ELSE                                            CONVERT(CHAR(2),DATEPART(MINUTE,GETDATE()))
                      END +
                      CASE WHEN DATEPART(SECOND,GETDATE()) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(SECOND,GETDATE()))
                           ELSE                                            CONVERT(CHAR(2),DATEPART(SECOND,GETDATE()))
                      END

   SELECT /*001*/ 'H01USERID' = 'SQ3CER1'
   ,      /*002*/ 'H01PROGRM' = 'EPC0001'
   ,      /*003*/ 'H01TIMSYS' = LTRIM(RTRIM(@iHora)) + LTRIM(RTRIM(@iFecha))
   ,      /*004*/ 'H01SCRCOD' = '01'
   ,      /*005*/ 'H01OPECOD' = CASE WHEN @Anulación = 'N' THEN '0001' ELSE '0002' END
   ,      /*006*/ 'H01FLGMAS' = ' '
   ,      /*007*/ 'H01FLGWK1' = ' '
   ,      /*008*/ 'H01FLGWK2' = ' '
   ,      /*009*/ 'H01FLGWK3' = ' '
   ,      /*011*/ 'PCFECING'  = CONVERT(CHAR(10),M.Fecha,112)
   ,      /*012*/ 'PCNUMOPE'  = M.OperacionBac
   ,      /*013*/ 'PCTIPOPE'  = M.TipoOperacion
   ,      /*014*/ 'PCRUTCLI'  = RTRIM(LTRIM(M.RutCliente)) + C.cldv
   ,      /*015*/ 'PCMONORI'  = M.Moneda
   ,      /*016*/ 'PCMTOORI'  = M.MontoMx
   ,      /*017*/ 'PCMONEQU'  = M.MonedaCnv
   ,      /*018*/ 'PCMTOEQU'  = M.MontoMonedaCnv
   ,      /*019*/ 'PCMTOCAM'  = M.TipoCambio
   ,      /*020*/ 'PCPARIDA'  = M.Paridad
   ,      /*021*/ 'PCTIPMER'  = M.MercadoCambiario
   ,      /*022*/ 'PCFORPAG'  = M.FormaPago
   ,      /*023*/ 'PCESTADO'  = M.Estado
   ,      /*024*/ 'PCUSUARIO' = M.Usuario
   FROM   MERCADO_CAMBIARIO M
          LEFT JOIN BacParamSuda..CLIENTE C ON M.RutCliente = C.clrut AND M.CodCliente = C.clcodigo
   WHERE  M.OperacionBac        = @iOperacion

END
GO
