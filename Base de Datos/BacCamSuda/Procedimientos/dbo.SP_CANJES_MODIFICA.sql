USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANJES_MODIFICA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CANJES_MODIFICA]
         (
            @NUMOPER       NUMERIC(5),
            @MONTO         NUMERIC(19,4),   
            @RUTCLI        NUMERIC(9)   , 
            @TIPOCAMBBCO   NUMERIC(19,4),
            @TIPOCAMBCLI   NUMERIC(19,4),
            @FPAGOMXBCO    NUMERIC(5),
            @FPAGOMXCLI    NUMERIC(5),
            @FPAGOMNBCO    NUMERIC(5),
            @FPAGOMNCLI    NUMERIC(5),
            @OBSERVA       VARCHAR(250),
            @VALUTA1       DATETIME,
            @VALUTA2       DATETIME,
            @VALUTA3       DATETIME,
            @VALUTA4       DATETIME,
            @OPERADOR      CHAR(10),
            @FECHA         DATETIME,
--            @HORA          CHAR(8),
            @TERMINAL      CHAR(12)
         )
AS 
BEGIN
            SET NOCOUNT ON
         
         DECLARE @CODCLI    NUMERIC(5)
         DECLARE @NOMCLI    CHAR(35)
         DECLARE @OBSERV    NUMERIC(19,4)
         DECLARE @TIPOMER   CHAR (4)
         DECLARE @TIPOPER   CHAR (1)
         DECLARE @ENTIDAD   NUMERIC (9)
         DECLARE @CODIGOMON CHAR(3)
         DECLARE @CODMONCNV CHAR(3)
               -- RESCATA EL  RUT Y NOMBRE DEL CLIENTE
            SELECT @CODCLI = ( SELECT clcodigo FROM VIEW_CLIENTE WHERE clrut = @RUTCLI )
            SELECT @NOMCLI = ( SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = @RUTCLI AND clcodigo = @CODCLI )
               -- RESCATA EL VALOR DEL DOLAR OBSERVADO
            SELECT @OBSERV = ( SELECT acobser FROM MEAC WHERE acentida = 'ME' )
            BEGIN TRANSACTION
            UPDATE MEMO
                     SET  
                    -- moentidad           =   @entidad
                    --,motipmer            =   @tipomer
                    --,monumope            =   @numoper
                    --,motipope            =   @tipoper
                     morutcli              =   @RUTCLI   
                    ,mocodcli              =   @CODCLI 
                    ,monomcli              =   @NOMCLI
                    --,mocodmon            =   @codigomon
                    --,mocodcnv            =   @codmoncnv
                    ,momonmo               =   @MONTO 
                    ,moticam               =   @TIPOCAMBBCO
                    ,moentre               =   @FPAGOMXBCO 
                    ,morecib               =   @FPAGOMNBCO
                    ,forma_pago_cli_nac    =   @FPAGOMXCLI
                    ,forma_pago_cli_ext    =   @FPAGOMNCLI
                    ,movaluta1             =   @VALUTA1 
                    ,movaluta2             =   @VALUTA2
                    ,valuta_cli_nac        =   @VALUTA3 
                    ,valuta_cli_ext        =   @VALUTA4 
                    ,motctra               =   @TIPOCAMBCLI 
                    --,precio_cliente      =   @monto
                    --,mofech              =   @fecha  
                    ,mooper              =   @OPERADOR 
                    --,mofech              =   @fecha
                    ,mohora                =   convert(char(8),getdate(),108)
                    ,moterm              =   @TERMINAL 
     ,observacion     =   @OBSERVA
       
            WHERE  @NUMOPER  =   MONUMOPE
                  
         IF @@ERROR <> 0 
             ROLLBACK TRANSACTION
         IF @@ERROR = 0
             COMMIT TRANSACTION
          SELECT @NUMOPER
          SET NOCOUNT OFF
END



GO
