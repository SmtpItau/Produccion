USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANJES_GRABA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CANJES_GRABA] 
         (
             @MONTO            NUMERIC(19,4)
            ,@RUTCLI           NUMERIC(9)
            ,@TIPOCAMBBCO      NUMERIC(19,4)
            ,@TIPOCAMBCLI      NUMERIC(19,4)
            ,@FPAGOMXBCO       NUMERIC(3)
            ,@FPAGOMXCLI       NUMERIC(5)
            ,@FPAGOMNBCO       NUMERIC(3)
            ,@FPAGOMNCLI       NUMERIC(5)
            ,@OBSERVACIONES    CHAR(250)
            ,@VALUTA2          DATETIME
            ,@VALUTA1          DATETIME
            ,@VALUTA4          DATETIME
            ,@VALUTA3          DATETIME
            ,@OPERADOR         CHAR(10)
            ,@FECHA            DATETIME
            ,@HORA             CHAR(8)
            ,@TERMINAL         CHAR(12)
            ,@area             char(5)
            ,@comer            char(6)
            ,@consep           char(3)
            ,@CODOMA           numeric(3)
            ,@SISTEMA          char(3)
            ,@CONTABILIZA      char(1)
         )
AS 
BEGIN
        SET NOCOUNT ON
         DECLARE @NUMOPER      NUMERIC(5)
         DECLARE @CODCLI       NUMERIC(9)
         DECLARE @NOMCLI       CHAR(35)
         DECLARE @OBSERV       NUMERIC(19,4)
         DECLARE @TIPOMER      CHAR (4)
         DECLARE @TIPOPER      CHAR (1)
         DECLARE @ENTIDAD      NUMERIC (9)
         DECLARE @CODIGOMON    CHAR(3)
         DECLARE @CODMONCNV    CHAR(3)
         DECLARE @MONDOLAR     NUMERIC(19,4)
         DECLARE @PARIDA       NUMERIC(19,8)
         DECLARE @PRETRA       NUMERIC(19,4)
         DECLARE @MONTOPESOS   NUMERIC(19,4)
            
            select @PARIDA     = ( select vmparidad from VIEW_VALOR_MONEDA where vmcodigo = 994 and vmfecha = @FECHA )
               -- ACTUALIZA Y RESCATA EL NÂº DE OPERACION
               --UPDATE MEAC SET accorope = ( accorope + 1 )  WHERE acentida = 'ME'
     SELECT @NUMOPER    = ( SELECT accorope FROM MEAC ) + 1
               -- RESCATA EL  RUT Y NOMBRE DEL CLIENTE
            SELECT @CODCLI     = ( SELECT clcodigo FROM VIEW_CLIENTE WHERE clrut = @RUTCLI )
            SELECT @NOMCLI     = ( SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = @RUTCLI AND clcodigo = @CODCLI )
               -- RESCATA EL VALOR DEL DOLAR OBSERVADO
            SELECT @OBSERV     = ( SELECT acobser FROM MEAC WHERE acentida = 'ME' )
               -- ASIGNA EL TIPO DE MERCADO
            SELECT @TIPOMER    = 'CANJ' 
               -- ASIGNA EL TIPO DE OPERACION
            SELECT @TIPOPER    = 'C' 
               -- ASIGNA LA ENTIDAD
            SELECT @ENTIDAD    = ( SELECT accodigo FROM MEAC WHERE acentida = 'ME' )
               -- asigna los codigos de moneda
            SELECT @CODIGOMON  = 'USD'            
            SELECT @CODMONCNV  = 'USD'
     SELECT @HORA       = CONVERT(CHAR,GETDATE(),108)
            SELECT @PRETRA     = ( select vmvalor from VIEW_VALOR_MONEDA where vmcodigo = 994 and vmfecha = @FECHA )
     SELECT @MONTOPESOS = ( @MONTO * @TIPOCAMBBCO )
            
      BEGIN TRANSACTION
            
select @TIPOMER, @TIPOPER
      EXECUTE Sp_Gmovto
                  0
                        ,@TIPOMER
                        ,@TIPOPER
                        ,@RUTCLI
                        ,@CODCLI
                        ,@NOMCLI
                        ,@CODIGOMON   
                        ,@CODMONCNV
                        ,@MONTO
                        ,@TIPOCAMBBCO
                        ,@TIPOCAMBCLI 
                        ,@parida
                        ,@parida
                        ,@MONTO
                        ,@MONTO
                        ,@MontoPesos
                        ,@FPAGOMXBCO
                        ,@FPAGOMNBCO
                        ,@OPERADOR
                        ,@TERMINAL
                        ,@HORA
                        ,@FECHA
                        ,@CODOMA
                        ,' '
                        ,0 
                        ,@VALUTA1               
                        ,@VALUTA2               
                        ,0
                        ,''                      
   ,1                
                        ,0 
                        ,@pretra
   ,0-- @SISTEMA
   ,' '--@OPERADOR
                        ,@CONTABILIZA 
                        ,@OBSERVACIONES
   ,' '   
                        ,' '     
   ,' '     
   ,0      
   ,0      
   ,0 
                        ,@FPAGOMXCLI  
                        ,@FPAGOMNCLI
                        ,@VALUTA3
                        ,@VALUTA4
                        ,@area
                        ,@comer
                        ,@consep
                        ,0
                        ,0
                        ,0 
                        ,0
                        
         IF @@ERROR <> 0 
          BEGIN
     ROLLBACK TRANSACTION
     SELECT 'ERR'
     SET NOCOUNT OFF
     RETURN 
         END
                     
         COMMIT TRANSACTION
         SELECT @NUMOPER
         SET NOCOUNT OFF
END



GO
