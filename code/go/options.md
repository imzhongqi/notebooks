### option 模式的两种写法

#### 1.

```go
type Options struct {
    ServiceName string
    // some fields...
}

type Option func(opts *Options)

func ServiceName(s string) Option {
    return func (opts *Options) {
        opts.ServiceName = s
    }
}

func NewService(opts ...Option) {
    options := Options{}
    for _, o := range opts {
        o(&optinos)
    }
    // ...
}
```



#### 2.

```go
type Service struct {
    ServiceName string
}

type ServiceOption interface{
    apply(*Service)
}

type optionFunc(s *Service)

func (f optionFunc) apply(s *Service) {
    f(s)
}

func ServiceName(s string) ServiceOption {
    return optionFunc(func(s *Service) {
        s.ServiceName = s
    })
}

func NewService(opts ...ServiceOption) *Service {
    svc := Service{}
    for _, o := range opts {
        o.apply(&svc)
    }
    return &svc
}

```

