USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_STDCHARTERED_SPOT_FWD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INSERT_STDCHARTERED_SPOT_FWD]
	(	@Fecha						DATETIME		,  
		@Rut						NUMERIC( 9)		,  
		@CodigoCliente				NUMERIC( 9)		,  
		@Source						VARCHAR(3)		,  
		@DealType					TINYINT			,   
		@PureDealType				SMALLINT		,  
		@SourceReference			VARCHAR(20)		,  
		@TransType					TINYINT			,  
		@Revision					TINYINT			,  
		@TradeID					VARCHAR(20)		,  
		@DealerID					VARCHAR(20)		,  
		@DateOfDeal					DATETIME		,       
		@TimeOfDeal					VARCHAR(8)		,  
		@BankDealingCode			VARCHAR(10)		, /* CITG o CSLP*/  
		@BankName					VARCHAR(30)		,  
		@CounterPartyID				VARCHAR(10)		,  
		@Currency1					VARCHAR(3)		,  
		@Currency2					VARCHAR(3)		,  
		@PointsPremiumRate			NUMERIC(15,6)	,  
		@SpotBasicRate				FLOAT			,	--> NUMERIC(15,6)	,  
		@RateDirection				TINYINT			,  
		@ExchangeRatePeriod			FLOAT			,	--> NUMERIC(15,6)	,  
		@ValueDatePeriodCurrency1	DATETIME		,         
		@DealVolumePeriod1Currency1 NUMERIC(21,4)	,  
		@DealVolumePeriod1Currency2 NUMERIC(21,4)	,  
		@RateCurrency1AgainstUsd	NUMERIC(15, 6)
	)  
AS  
BEGIN  

	SET NOCOUNT ON  
  
	DECLARE @SISTEMA		AS VARCHAR(20)
	DECLARE @NOMBRE_CLI		AS CHAR(35)
	DECLARE @NUM_OPE_MEMO	AS NUMERIC(15,0)
	DECLARE @CLPAIS			AS NUMERIC(5,0)

	SET		@NOMBRE_CLI = ''      

	IF @rut = 0
		SELECT  @Rut			= S.clrut				,
                @CodigoCliente	= S.clcodigo			,
                @CLPAIS			= C.Clpais				,
				@Source			= isnull(SourceBac, '')	,  
				@Sistema		= isnull(System, '')
		FROM	bacparamsuda..sinacofi AS S 
				LEFT JOIN view_Cliente AS C	ON	S.clrut		= C.Clrut 
											AND S.clcodigo	= C.Clcodigo
        WHERE	BankDealinkCoded = RTRIM(@BankDealingCode)
  
	--> Se lee el nombre del cliente desde la tabla de clientes NO de SINACOFI.  
	SET @NOMBRE_CLI = ISNULL(( SELECT clnombre FROM BacParamSuda.dbo.CLIENTE with(nolock)  
											  WHERE clrut = @Rut and clcodigo = @CodigoCliente), '')
	--> Se lee el nombre del cliente desde la tabla de clientes NO de SINACOFI.  

	SET ROWCOUNT 0  
  
    IF @NOMBRE_CLI = ''
    BEGIN
		SELECT -1, 'Cliente' + @BankDealingCode +  ' No ha sido encontrado ','ER'
        RETURN
	END

    IF @rut = 0     
    BEGIN  
		SELECT -1,'CLIENTE ' + @BankDealingCode +  ' NO FUE RECONOCIDO PARA TRANSAR CON ' + @SISTEMA + CHAR(10) + CHAR(13) + 'VERIFIQUE PSEUDONIMOS','ER'  
        RETURN  
	END  
  
	-- INSERTAR   
    INSERT INTO tbl_StdChartered_Spot_Fwd 
	VALUES	(	@Fecha							,
				@Source							,
				@DealType						,
				@PureDealType					,
				@SourceReference				,
				@TransType						,
				@Revision						,
				@TradeID						,
				@DealerID						,
				@DateOfDeal						,
				@TimeOfDeal						,
				@BankDealingCode				,
				@BankName						,
				@CounterPartyID					,
				@Currency1						,
				@Currency2						,
				@PointsPremiumRate				,
				@SpotBasicRate					,
				@RateDirection					,
				@ExchangeRatePeriod				,
				@ValueDatePeriodCurrency1		,
				@DealVolumePeriod1Currency1		,
				@DealVolumePeriod1Currency2		,
				@RateCurrency1AgainstUsd		,
                           -1   
      )   
  
	IF @@Error <> 0  
    BEGIN  
		SELECT -1,		'ERROR AL INTENTAR GRABAR OPERACION ' 
					+	CONVERT(VARCHAR(20),ISNULL(@TradeID,@SourceReference)) 
					+	@SISTEMA
					+	CASE (@PureDealType)	WHEN 2 THEN ' SPOT'
												WHEN 4 THEN ' FORWARD' 
						END  
				,	'ER'            
    END ELSE   
	BEGIN     
          
		UPDATE	TBL_STDCHTD_STATUS
        SET		Status			= 'L'     
		,		Revision		= @Revision  
        WHERE	Source			= @Source 
		AND		SourceReference = @SourceReference 
		AND		PureDealType	= @PureDealType  
  
		SELECT		0
			,		'OPERACION '
				+	@SISTEMA 
				+	' '
				+	CONVERT(VARCHAR(20),	ISNULL(@TradeID,@SourceReference)	) 
				+	' GRABADA EXITOSAMENTE '
			,		'OK'
			,		@Rut
			,		@CodigoCliente
			,		@NOMBRE_CLI 
			,		@CLPAIS         
	END  

	SET NOCOUNT OFF  

END
GO
