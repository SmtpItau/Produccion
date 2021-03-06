USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BTR_CAMBIA_ESTADO_LBTR]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BTR_CAMBIA_ESTADO_LBTR]
   (   @par_sistema	    CHAR(03)
   ,   @par_num_operacion   NUMERIC(9,0)
   ,   @iEstado             CHAR(1) = ''
   )
AS 
BEGIN

   SET NOCOUNT ON

   DECLARE @ls_estado      CHAR(01)
       SET @ls_estado = ''

   DECLARE @sistema        CHAR(03)
   DECLARE @tipo_mercado   CHAR(12)
   DECLARE @tipo_operacion CHAR(05)

   SELECT @sistema	   = sistema	   
   ,      @tipo_mercado    = tipo_mercado     
   ,      @tipo_operacion  = tipo_operacion
   FROM	  MDLBTR           with (nolock)
   WHERE  sistema 	   = @par_sistema
   AND    numero_operacion = @par_num_operacion

   IF @sistema = 'BTR' 
   BEGIN
      IF @tipo_operacion IN('CP', 'CPAC', 'RC', 'ICOL','VICOL','VICAP','VPACT')
         SET @ls_estado = 'E'
      IF @tipo_operacion IN('VP', 'VI')
         SET @ls_estado = 'R'
   END

   IF @sistema = 'BCC' 
   BEGIN
      IF @tipo_operacion = 'CSPOT'
         SET @ls_estado = 'E'
      IF @tipo_operacion = 'VSPOT'
         SET @ls_estado = 'R'
   END

   IF @sistema = 'BFW' 
   BEGIN
      IF @tipo_operacion = 'VFUT'
         SET @ls_estado = 'E'
      IF @tipo_operacion = 'VFUTV'
         SET @ls_estado = 'R'
   END

   UPDATE MDLBTR	
   SET    estado_envio     = CASE WHEN @iEstado                = ''  THEN @ls_estado 
                                  ELSE CASE WHEN estado_envio <> 'E' THEN @iEstado 
                                            ELSE                          'E'
                                       END
                             END 
   WHERE  sistema	   = @par_sistema	
   AND    numero_operacion = @par_num_operacion

END
GO
