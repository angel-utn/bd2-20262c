Use EjemploTriggersyTransaccionesDB;

Go
-- En lugar de borrar un registro de Movimientos, guardarlo en la tabla de auditoria.
Create Or Alter Trigger tr_MovimientoBorrado On Movimientos
Instead Of Delete
As
BEGIN
    Insert Into AuditoriaMovimientos (IDMovimiento, FechaHora)
    Select IdMovimiento, Getdate() From deleted;

    -- Delete From Movimientos Where IDMovimiento In (Select IDMovimiento From deleted);
End;

Go

Delete From Movimientos Where IDMovimiento = 9;

Select * From AuditoriaMovimientos;
Select * From Movimientos;

Go
-- Luego de insertar un movimiento, actualizar los datos de la cuenta
Create Trigger tr_InsertarMovimiento On Movimientos
After Insert
As Begin
Begin Try
        Begin Transaction 

        Declare @IdCuenta int
        Declare @TipoMovimiento char
        Declare @Importe money

        Select @IdCuenta = IdCuenta, @TipoMovimiento = TipoMovimiento, @Importe = Importe from inserted;
    
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
End


Select * From Cuentas Where IdCuenta = 9;
Select * From Movimientos Where IdCuenta = 9;

-- Ok
Insert into Movimientos(IDCuenta, Fecha, TipoMovimiento, Importe)
Values (9, getdate(), 'C', 900);

-- Falla
Insert into Movimientos(IDCuenta, Fecha, TipoMovimiento, Importe)
Values (9, getdate(), 'D', 901);



--- Actividad adicional
-- Luego de agregar un cliente, agregar una cuenta de tipo Caja de Ahorro con $10000 de saldo y sin límite descubierto.
-- En lugar de eliminar un cliente, realizar una baja lógica.
