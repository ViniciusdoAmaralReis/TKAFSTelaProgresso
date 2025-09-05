unit uKAFSTelaProgresso;

interface

uses
  System.Classes, System.SysUtils, System.UITypes,
  FMX.Ani, FMX.Graphics, FMX.Objects, FMX.StdCtrls, FMX.Types;

type
  TKAFSTelaProgresso = class(TRectangle)
    cirIndicador: TCircle;
    aniIndicador: TFloatAnimation;
    labDescricao1: TLabel;
    rectProgresso: TRectangle;
    labDescricao2: TLabel;
    labCancelar: TLabel;

    constructor Create(AOwner: TComponent); reintroduce;
    procedure Progresso(const _cortema1, _cortema2: TAlphaColor; const _descricao: String; const _parcial, _total: Integer; const _cancelar: TNotifyEvent);
    destructor Destroy; override;
  end;

implementation

constructor TKAFSTelaProgresso.Create(AOwner: TComponent);
begin
  TThread.Synchronize(nil, procedure
  begin
    inherited Create(AOwner);

    Align := TAlignLayout.Contents;
    Parent := TFmxObject(AOwner);
    Stroke.Kind := TBrushKind.None;
    Visible := False;

    cirIndicador := TCircle.Create(Self);
    begin
      cirIndicador.Align := TAlignLayout.Center;
      cirIndicador.Fill.Kind := TBrushKind.None;
      cirIndicador.Height := 100;
      cirIndicador.Parent := Self;
      cirIndicador.Stroke.Cap := TStrokeCap.Round;
      cirIndicador.Stroke.Dash := TStrokeDash.Dash;
      cirIndicador.Stroke.Kind := TBrushKind.Solid;
      cirIndicador.Stroke.Thickness := 20;
      cirIndicador.Width := 100;
    end;

    aniIndicador := TFloatAnimation.Create(cirIndicador);
    begin
      aniIndicador.Duration := 2;
      aniIndicador.Loop := True;
      aniIndicador.Parent := CirIndicador;
      aniIndicador.PropertyName := 'RotationAngle';
      aniIndicador.StopValue := 360;
    end;

    labDescricao1 := TLabel.Create(Self);
    begin
      labDescricao1.Align := TAlignLayout.VertCenter;
      labDescricao1.Font.Family := 'Roboto';
      labDescricao1.Font.Size := 20;
      labDescricao1.Font.Style := [TFontStyle.fsBold];
      labDescricao1.Height := 50;
      labDescricao1.Margins.Top := 200;
      labDescricao1.Parent := Self;
      labDescricao1.StyledSettings := [];
      labDescricao1.TextSettings.HorzAlign := TTextAlign.Center;
    end;

    rectProgresso := TRectangle.Create(Self);
    begin
      rectProgresso.Align := TAlignLayout.Center;
      rectProgresso.Height := 5;
      rectProgresso.Margins.Top := 250;
      rectProgresso.Parent := Self;
      rectProgresso.Stroke.Kind := TBrushKind.None;
      rectProgresso.XRadius := rectProgresso.Height / 2;
      rectProgresso.YRadius := rectProgresso.Height / 2;
    end;

    labDescricao2 := TLabel.Create(Self);
    begin
      labDescricao2.Align := TAlignLayout.VertCenter;
      labDescricao2.Font.Family := 'Segoe UI Emoji';
      labDescricao2.Font.Size := 14;
      labDescricao2.Margins.Top := 300;
      labDescricao2.Parent := Self;
      labDescricao2.StyledSettings := [];
      labDescricao2.TextSettings.HorzAlign := TTextAlign.Center;
    end;

    labCancelar := TLabel.Create(Self);
    begin
      labCancelar.Align := TAlignLayout.MostBottom;
      labCancelar.Cursor := crHandPoint;
      labCancelar.HitTest := True;
      labCancelar.Font.Family := 'Segoe UI Emoji';
      labCancelar.Font.Size := 14;
      labCancelar.Margins.Bottom := 100;
      labCancelar.Parent := Self;
      labCancelar.StyledSettings := [];
      labCancelar.TextSettings.Font.Style := [TFontStyle.fsUnderline];
      labCancelar.TextSettings.HorzAlign := TTextAlign.Center;
    end;
  end);
end;

procedure TKAFSTelaProgresso.Progresso(const _cortema1, _cortema2: TAlphaColor; const _descricao: String; const _parcial, _total: Integer; const _cancelar: TNotifyEvent);
begin
  if _total <= 0 then
    Exit;

  TThread.Synchronize(nil, procedure
  begin
    // Cor do fundo
    Fill.Color := _cortema1;

    // Cor do indicador
    cirIndicador.Stroke.Color := _cortema2;

    // Texto e cor da descrição 1
    with labDescricao1 do
    begin
      Text := _descricao;
      TextSettings.FontColor := _cortema2;
    end;

    // Cor e cáculo de tamanho da barra de progresso
    with rectProgresso do
    begin
      Fill.Color := _cortema2;
      Width := ((_total - _parcial) / _total) * Width;
    end;

    // Texto e cor da descrição 2
    with labDescricao2 do
    begin
      Text := IntToStr(_parcial)+' de '+IntToStr(_total);
      TextSettings.FontColor := _cortema2;
    end;

    // Se existe um evento de cancelamento, configura texto e cor
    if Assigned(_cancelar) then
      with labCancelar do
      begin
        Text := 'Cancelar';
        TextSettings.FontColor := _cortema2;

        OnClick := _cancelar;
      end;

    // Iniciar animação
    aniIndicador.Start;

    // Torna visível e traz o componente para frente
    Visible := True;
  end);
end;

destructor TKAFSTelaProgresso.Destroy;
begin
  TThread.Synchronize(nil, procedure
  begin

    inherited Destroy;
  end);
end;

end.
