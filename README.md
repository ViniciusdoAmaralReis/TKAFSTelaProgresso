# 🚀 TKAFSTelaProgresso

Componente Delphi/FireMonkey para exibição de tela de progresso com animação e barra de progresso visual.

## 📋 Descrição

Componente especializado em exibir telas de progresso em aplicações Delphi/FireMonkey, com suporte multiplataforma e recursos visuais avançados para feedback de operações em andamento.

## ✨ Características

- ✅ Indicador de progresso animado circular
- ✅ Barra de progresso visual
- ✅ Suporte multiplataforma (Windows, Android, iOS, etc.)
- ✅ Textos descritivos customizáveis
- ✅ Botão de cancelamento opcional
- ✅ Cores totalmente personalizáveis
- ✅ Animação contínua durante operações

## 🛠️ Configuração

### Parâmetros Padrão

```
AnimationDuration: 2 segundos
CircleIndicatorSize: 100x100 pixels
ProgressBarHeight: 5 pixels
MainFontSize: 48 (Roboto Bold)
SecondaryFontSize: 20 (Segoe UI Emoji)
CancelFontSize: 15 (Segoe UI Emoji)
```

## 📦 Como Usar

### Instanciação Básica

```pascal
var
  TelaProgresso: TKAFSTelaProgresso;
begin
  TelaProgresso := TKAFSTelaProgresso.Create(Self);
  try
    TelaProgresso.Progresso(TAlphaColors.White, TAlphaColors.Blue, 
      'Processando...', 50, 100, nil);
    // Sua operação demorada aqui
  finally
    TelaProgresso.Free;
  end;
end;
```

### Métodos Principais

| Método | Descrição |
|--------|-----------|
| `Progresso` | Exibe e atualiza a tela de progresso |
| `Create` | Construtor com criação dos componentes visuais |
| `Destroy` | Destrutor com parada segura da animação |

### Parâmetros do Método Progresso

```pascal
procedure Progresso(
  const _cortema1: TAlphaColor;    // Cor de fundo
  const _cortema2: TAlphaColor;    // Cor dos elementos e texto
  const _descricao: String;        // Descrição principal
  const _parcial: Integer;         // Progresso atual
  const _total: Integer;           // Progresso total
  const _cancelar: TNotifyEvent    // Evento de cancelamento (opcional)
);
```

## 🔧 Dependências

- `System.Classes`
- `System.SysUtils`
- `System.UITypes`
- `FMX.Ani`
- `FMX.Graphics`
- `FMX.Objects`
- `FMX.StdCtrls`
- `FMX.Types`

## 🎨 Personalização

### Cores
- Fundo do container (`_cortema1`)
- Elementos visuais e texto (`_cortema2`)

### Textos
- Descrição principal (font size 48, bold)
- Contador de progresso (font size 20)
- Botão de cancelamento (font size 15, sublinhado)

### Layout
- Indicador circular central com animação de rotação
- Barra de progresso na parte inferior
- Textos centralizados horizontalmente

## ⚠️ Tratamento de Animação

- A animação é automaticamente iniciada ao exibir o progresso
- A animação é parada seguramente ao destruir o componente
- Loop infinito até explicitamente parado

## 🎯 Comportamento

- Exibe progresso parcial/total numericamente
- Atualiza visualmente a barra de progresso
- Permite cancelamento através de evento click
- Traz o componente para frente quando exibido

---

**Nota:** Este componente é ideal para operações demoradas que requerem feedback visual ao usuário, como downloads, processamentos ou sincronizações.
