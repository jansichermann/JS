#import "JSMapViewTableViewCell.h"
@import MapKit;


@interface JSMapViewTableViewCellModel()
@property (nonatomic)       CGFloat             height;
@property (nonatomic)       id<MKAnnotation>    annotation;
@end


@implementation JSMapViewTableViewCellModel

+ (instancetype)withHeight:(CGFloat)height
                annotation:(id<MKAnnotation>)annotation {
    NSParameterAssert([annotation conformsToProtocol:@protocol(MKAnnotation)]);
    JSMapViewTableViewCellModel *m = [[JSMapViewTableViewCellModel alloc] init];
    m.height = height;
    m.annotation = annotation;
    return m;
}

@end



@implementation JSMapViewTableViewCell

+ (CGFloat)heightForModel:(JSMapViewTableViewCellModel *)model
              inTableView:(UITableView *)tableView {
    NSParameterAssert([model isKindOfClass:[JSMapViewTableViewCellModel class]]);
    return model.height;
}


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    MKMapView *mv = [[MKMapView alloc] initWithFrame:self.contentView.bounds];
    mv.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:mv];
    
    self.configureBlock = ^(JSMapViewTableViewCellModel *model) {
        [mv removeAnnotations:mv.annotations];
        [mv addAnnotation:model.annotation];
        [mv setRegion:
         MKCoordinateRegionMake(model.annotation.coordinate,
                                MKCoordinateSpanMake(0.002, 0.002))];
    };
    return self;
}

@end
