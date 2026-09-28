-- Procedimientos Almacenados (stored procedures)
-- sp_ObtenerMovimientosDeCuenta (idcuenta)

-- DDL
-- Create, Alter, Drop

-- DML
-- Insert, Update, Delete

Create Or Alter Procedure sp_ObtenerMovimientosDeCuenta(
    @IdCuenta int
)
As
BEGIN
    Select
        Mov.*,
        Cu.IDCliente,
        Cu.IDTipoCuenta
    From Movimientos Mov
    Inner Join Cuentas Cu On Mov.IDCuenta = Cu.IDCuenta
    Where Cu.IDCuenta = @IdCuenta
End

Exec sp_ObtenerMovimientosDeCuenta 1

Go
-- Procedure para registrar un movimiento a una cuenta
-- ---------------------------------------------------

-- Debe recibir como parámetro los valores necesarios para crear un registro de Movimiento
-- Tiene que insertar un movimiento en la tabla Movimientos
-- Actualizo el saldo de la cuenta
    -- Si no hubo ningún error -- Commit (confirmo ambos cambios)
    -- Si hubo algún error -- Rollback (retrotraigo ambos cambios)

Create or Alter Procedure sp_AgregarMovimiento(
    @IdCuenta int,
    @Importe money,
    @TipoMovimiento char
)
As
BEGIN

    Begin Try
        Begin Transaction 
        
        Insert into Movimientos (IDCuenta, Fecha, TipoMovimiento, Importe)
        Values (@IdCuenta, Getdate(), @TipoMovimiento, @Importe);

        If @TipoMovimiento = 'D' BEGIN
            Set @Importe = @Importe * -1;
        End

        Update Cuentas Set Saldo = Saldo + @Importe Where IDCuenta = @IdCuenta;

        Commit Transaction
    End Try
    Begin Catch
        Rollback TRANSACTION
        Declare @Mensaje varchar(5000);
        Set @Mensaje = ERROR_MESSAGE();
        RAISERROR('Hubo un error al registrar el movimiento: %s', 16, 1, @Mensaje);
    End Catch
END

Select * From Cuentas Where IdCuenta = 8;
Exec sp_ObtenerMovimientosDeCuenta 8

Exec sp_AgregarMovimiento 8, 250, 'D'

-- 1, 500, 'D'
-- 1, 1000, 'C'