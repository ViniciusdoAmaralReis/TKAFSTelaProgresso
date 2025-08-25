unit uKAFSTelaProgresso;

interface

uses
  System.Classes, System.SysUtils, System.UITypes,
  FMX.Ani, FMX.Graphics, FMX.Objects, FMX.StdCtrls, FMX.Types;

type
  TKAFSTelaProgresso = class(TRectangle)
    CirIndicador: TCircle;
    AniIndicador: TFloatAnimation;
    LabDescricao1: TLabel;
    RecProgresso: TRectangle;
    LabDescricao2: TLabel;
    LabCancelar: TLabel;

    constructor Create(AOwner: TComponent); reintroduce;
    procedure Progresso(const _cortema1, _cortema2: TAlphaColor; const _descricao: String; const _parcial, _total: Integer; const _cancelar: TNotifyEvent);
    destructor Destroy; override;
  end;

implementation

constructor TKAFSTelaProgresso.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Align := TAlignLayout.Contents;
  Parent := TFmxObject(AOwner);
  Stroke.Kind := TBrushKind.None;
  Visible := False;

  CirIndicador := TCircle.Create(Self);
  with CirIndicador do
  begin
    Align := TAlignLayout.Center;
    Fill.Kind := TBrushKind.None;
    Height := 100;
    Margins.Bottom := 200;
    Parent := Self;
    Stroke.Cap := TStrokeCap.Round;
    Stroke.Dash := TStrokeDash.Dash;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Thickness := 20;
    Width := 100;
  end;

  AniIndicador := TFloatAnimation.Create(Self);
  with AniIndicador do
  begin
    Duration := 2;
    Enabled := True;
    Loop := True;
    Parent := CirIndicador;
    PropertyName := 'RotationAngle';
    StartFromCurrent := True;
    StopValue := 360;

    TThread.Queue(nil, procedure begin Start; end);
  end;

  LabDescricao1 := TLabel.Create(Self);
  with LabDescricao1 do
  begin
    Align := TAlignLayout.Contents;
    Font.Family := 'Roboto';
    Font.Size := 36;
    Font.Style := [TFontStyle.fsBold];
    Parent := Self;
    StyledSettings := [];
    TextSettings.HorzAlign := TTextAlign.Center;
  end;

  RecProgresso := TRectangle.Create(Self);
  with RecProgresso do
  begin
    Align := TAlignLayout.Center;
    Height := 5;
    Margins.Top := 100;
    Parent := Self;
    Stroke.Kind := TBrushKind.None;
    Width := Self.Width / 5;
    XRadius := Height / 2;
    YRadius := Height / 2;
  end;

  LabDescricao2 := TLabel.Create(Self);
  with LabDescricao2 do
  begin
    Align := TAlignLayout.Contents;
    Font.Family := 'Segoe UI Emoji';
    Font.Size := 24;
    Margins.Top := 150;
    Parent := Self;
    StyledSettings := [];
    TextSettings.HorzAlign := TTextAlign.Center;
  end;

  LabCancelar := TLabel.Create(Self);
  with LabCancelar do
  begin
    Align := TAlignLayout.MostBottom;
    Cursor := crHandPoint;
    HitTest := True;
    Font.Family := 'Segoe UI Emoji';
    Font.Size := 18;
    Margins.Bottom := 200;
    Margins.Top := -(Height + Margins.Bottom);
    Parent := Self;
    StyledSettings := [];
    TextSettings.Font.Style := [TFontStyle.fsUnderline];
    TextSettings.HorzAlign := TTextAlign.Center;
  end;
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
    CirIndicador.Stroke.Color := _cortema2;

    // Texto e cor da descrição 1
    with LabDescricao1 do
    begin
      Text := _descricao;
      TextSettings.FontColor := _cortema2;
    end;

    // Cor e cáculo de tamanho da barra de progresso
    with RecProgresso do
    begin
      Fill.Color := _cortema2;
      Width := ((_total - _parcial) / _total) * Width;
    end;

    // Texto e cor da descrição 2
    with LabDescricao2 do
    begin
      Text := IntToStr(_parcial)+' de '+IntToStr(_total);
      TextSettings.FontColor := _cortema2;
    end;

    // Se existe um evento de cancelamento, configura texto e cor
    if Assigned(_cancelar) then
      with LabCancelar do
      begin
        Text := 'Cancelar';
        TextSettings.FontColor := _cortema2;

        OnClick := _cancelar;
      end;

    // Torna visível e traz o componente para frente
    Visible := True;
  end);
end;

destructor TKAFSTelaProgresso.Destroy;
begin

  inherited Destroy;
end;

end.
