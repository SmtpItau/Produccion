USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FxSpread]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[FxSpread]
	(	@NumOper		numeric(9)
	,	@dFecha			datetime
	)	returns numeric(21,4)
as
begin

	declare @Spread		numeric(21,4)
		set @Spread		= 0.0

	set		@Spread		= isnull((select sum((tasa_compra - tasa_mercado) * movalvenp) / sum( movalvenp )
							from	BacTraderSuda.dbo.Mdmh with(nolock)
									inner join BacTradersuda.dbo.Valorizacion_Mercado  On	fecha_valorizacion	= mofecpro
																						and rmnumoper			= monumoper
																						and	rmnumdocu			= monumdocu
																						and	rmcorrela			= mocorrela
							where	mofecpro			= @dFecha
							and		motipoper			IN('CI', 'VI')
							and		mostatreg			= ''
							and		motipoper			= 'VI'
							and		motipopero			= 'CP'
							and		monumoper			= @NumOper
							group by monumoper
						), 0.0)

	return @Spread

end
GO
